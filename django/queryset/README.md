# QuerySet

## Sample models

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

## Using `.select_related()` and `.prefetch_related()`

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

## Using `.first()` instead of calling `.exists()`, followed by `.get()`

```python
# Yes
matched_person = Person.objects.filter(employee_id='123').first()
if matched_person:
    do_something(matched_person)

# No
if Person.objects.filter(employee_id='123').exists():
    matched_person = Person.objects.get(employee_id='123')
    do_something(matched_person)
```

The reason is calling a single `.first()` will hit database only one. But when we call `.exists()`, it hits. Calling `.get()` will hits database again. Makes the second method to hit database twice which is a bad idea.

## Joint Field Filtering

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

## Using `.count()` instead of `len()`

```python
# Yes
Person.objects.count()     # SELECT COUNT(*) FROM person

# No
len(Person.objects.all())  # SELECT * FROM person
```

Selecting aggregate function from database always consume less time that getting every records.

## `.update()` is more preferred than looping save models

```python
# Yes
Person.objects.update(active=False)  # hit database

# No
for person in Person.objects.all():
    person.active = False
    person.save()                    # hit database (n times)
```

Calling `QuerySet.update()` will produce a single query using `UPDATE ... WHERE ...` faster than looping update the model in Python which hit database every iteration.

## Select/Prefetch related only when you're using those values

```python
any_user = User.objects.first()

# No need to use `select_related` since you only filter it.
Person.objects.filter(user=any_user)

# You need to, because you're accessing user instance
person = Person.objects.select_related('user').first()
print(person.user.username)
```

## Avoid filtering across many relationship

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

---
<sup>[1]</sup> See more about `through` here.

## No Raw SQL
