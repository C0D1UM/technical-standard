# QuerySet

## Introduction

This guideline will base on these models:

```python
class User(models.Model):
    username = models.CharField(max_length=50)


class Person(models.Model):
    user = models.ForeignKey(
        'User',
        on_delete=models.CASCADE,
        related_name='people',
    )
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=150)
    employee_id = models.CharField(max_length=15, unique=True)
    active = models.Boolean(default=True, blank=True)


class Department(models.Model):
    name = models.CharField(max_length=255)

    members = models.ManyToManyField(
        'Person',
        related_name='departments',
    )
```

## Filtering

### Joint Field Filtering

```python
# Yes
def find_people_yes(query: str):
    return Person.objects.annotate(
        full_name=Concat('first_name', Value(' '), 'last_name'),
    ).filter(
        full_name__icontains=query,
    )

# No
def find_people_no(query: str):
    return Person.objects.filter(
        Q(first_name__icontains=query)
        | Q(last_name__icontains=query)
    )
```

First, we try to filter people with name `John`...

```python
people = find_people_yes(query='John')
# return: <QuerySet [<Person: John Doe>, <Person: John Wick>]>

people = find_people_no(query='John')
# return: <QuerySet [<Person: John Doe>, <Person: John Wick>]>
```

Everything seems fine, right? Both techniques return the same results. But what about filtering person's name by `John Doe`?

```python
people = find_people_yes(query='John Doe')
# return: <QuerySet [<Person: John Doe>]>

people = find_people_no(query='John Doe')
# return: <QuerySet []>
```

Now you see the difference? It's because the second method (`find_people_no`) does not support filtering across two fields.

So if you have a requirement like this, you should join two fields together before filter them.

### Using `.count()` instead of `len()`

```python
# Yes
Person.objects.count()     # SELECT COUNT(*) FROM person

# No
len(Person.objects.all())  # SELECT * FROM person
```

Selecting aggregate function from database always consume less time that getting every records.

### Using `.exists()` to check if any data exists

```python
# Yes
if Person.objects.filter(first_name='John').exists():
    do_something()

# No
if Person.objects.filter(first_name='John'):
    do_something()
```

Using `.exists()` consume less resources than not using it.

### Using `.first()` instead of calling `.exists()`, followed by `.get()`

```python
# Yes
matched_person = Person.objects.filter(employee_id='123').first()
if matched_person is not None:
    do_something(matched_person)

# No
if Person.objects.filter(employee_id='123').exists():
    matched_person = Person.objects.get(employee_id='123')
    do_something(matched_person)
```

The reason is calling a single `.first()` will hit database only one. But when we call `.exists()`, it hits. Calling `.get()` will hits database again. Makes the second method to hit database twice which is a bad idea.

### Avoid filtering across many relationship

Filtering across _one-to-many_ or _many-to-many_ relationship can cause an unexpected result such as duplicated records.

Suppose we have two departments

```python
hr = Department.objects.create(name='HRD')
accounting = Department.objects.create(name='HRM')
```

John Doe is in both departments

```python
john_doe = Person.objects.create(...)
hr.add(john_doe)
accounting.add(john_doe)
```

If we try to get person who is in department that it's name contains word `HR`

```python
Person.objects.filter(departments__name__icontains='HR')
# return: <QuerySet [<Person: John Doe>, <Person: John Doe>]>
```

We will get duplicated records because John Doe is in both departments. The solution for this case is to use `.distinct()`

```python
Person.objects.filter(departments__name__icontains='HR').distinct()
# return: <QuerySet [<Person: John Doe>]>
```

### No need to use `.all()` before `.filter()`

If you're using `.filter()` in your queryset, then you don't need to provide `.all()` anymore

```python
# Yes
Person.objects.filter(first_name='John')

# No
Person.objects.all().filter(first_name='John')
```

### Avoid filtering against `JSONField`

Filtering against `JSONField` can cause a huge performance degrades.

If it is really needed to filter, then you might need to consider refactoring your model by using database relation (such as _one-to-many_ or _many-to-many_) to represent your data instead.

### `Q() | Q()` is more preferred than union queryset

```python
# Yes
queryset = Person.objects.filter(
    Q(first_name='John') | Q(last_name='Doe')
)

# No
queryset = Person.objects.filter(first_name='John')
queryset.union(
    Person.objects.filter(last_name='Doe')
)
```

The first method will generate a query such as `SELECT ... FROM ... WHERE ... OR ...` which is faster than the second one which will generate `SELECT ... FROM ... WHERE ... UNION SELECT ... FROM ... WHERE ...`.

## Manipulating Data

### `.update()` is more preferred than looping save models

```python
# Yes
Person.objects.update(active=False)  # hit database

# No
for person in Person.objects.all():
    person.active = False
    person.save()                    # hit database (n times)
```

Calling `QuerySet.update()` will produce a single query using `UPDATE ... WHERE ...`. It is faster than looping update the model in Python which hit database every iteration.

### Refresh model from database

```python
# Getting John
john = Person.objects.get(first_name='John', active=True)
# Set John to inactive
Person.objects.filter(pk=person.pk).update(active=False)

print(john.active)
# return: True

john.refresh_from_db(fields=['active'])
print(john.active)
# return: False
```

When you update a model field using `.update()`, a local instance won't update automatically. You'll need to call `.refresh_from_db()` to refresh an instance from database.

## Related Models

### Using `.select_related()` and `.prefetch_related()`

```python
# Yes
person = Person.objects \
    .select_related('user') \
    .prefetch_related('departments') \
    .first()                                 # hit database
print(person.first_name)
print(person.user.username)
print(person.departments.all())

# No
person = Person.objects.first()              # hit database
print(person.first_name)
print(person.user.username)                  # hit database
print(person.departments.all())              # hit database
```

The second method seems short and easy to understand. But behind that, it hits database 3 times.

> **WARNING:** Calling `person.departments.filter(name='HR')` in both methods will hit database since it needs to query database to find the records which matched the given condition. `prefetch_related` does not help you in this situation.

### Select/Prefetch related only when you're using those values

```python
any_user = User.objects.first()

# No need to use `select_related` since you only filter it.
Person.objects.filter(user=any_user)

# You need to, because you're accessing user instance
person = Person.objects.select_related('user').first()
print(person.user.username)
```

### Avoid comparing instance if not select/prefetch related

```python
person = Person.objects.first()
user = User.objects.first()

# Yes
if person.user_id == user.pk:    # no database hit
    do_something()

# No
if person.user == user:          # hit database
    do_something()
```

The first method doesn't hit the database because field `user_id` is in `Person` instance locally.

The second one hit the database because accessing `user` property makes Django to query `User` instance.

## Custom Manager

### Repeat filtering logics

If you have any repeat filtering logics, it is recommended to adding an extra manager function instead of repeating yourself in multiple location.

```python
class PersonManager(models.Manager):
    def only_inactive(self):
        return self.filter(active=False)


class Person(models.Model):
    ...
    objects = PersonManager()


# Then you can call it with
Person.objects.only_inactive()
```

### Override default queryset

For example, if you want the default behavior to filter only active person.

```python
class PersonManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter(active=True)


class Person(models.Model):
    ...
    objects = PersonManager()


Person.objects.all()  # will now showing only active person
```

## Other

### No Raw SQL

Writing query in _Raw SQL_ format can cause many problems.

The most important reason is _the difficulty to maintain_. If you write a lot of queries, it will be difficult to understand the logics of those queries. Makes it difficult to modify as well.

The second one is _security_. Writing _Raw SQL_ can cause a SQL injection if you don't carefully escape every parameters used in the queries.

The last reason is _it can goes wrong easily_. By using _Raw SQL_, you'll need to write it as a plain text. If you're using IDE that support validating SQL language, you might be lucky. But if you aren't, you'll easily mess things up. Checking with a real database query should be done frequently.

Django provides a lot of utility functions which can help you writing queries without using _Raw SQL_ such as [Subquery](https://docs.djangoproject.com/en/3.1/ref/models/expressions/#subquery-expressions), [Func](https://docs.djangoproject.com/en/3.1/ref/models/expressions/#func-expressions), [Aggregate](https://docs.djangoproject.com/en/3.1/ref/models/expressions/#aggregate-expressions), and etc.

Anyway, there might be a case that you cannot prevent using _Raw SQL_. If that time comes, please be very careful.

---

## References

- [QuerySet API reference](https://docs.djangoproject.com/en/3.1/ref/models/querysets/)
- [Making queries](https://docs.djangoproject.com/en/3.1/topics/db/queries/)
- [Managers](https://docs.djangoproject.com/en/3.1/topics/db/managers/)
