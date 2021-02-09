# QuerySet

## Sample Models

This guideline will base on this `Person` model:

```python
class Person(models.Model):
    user = models.ForeignKey(
        get_user_model(),
        on_delete=models.CASCADE,
        related_name='person',
    )
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=150)
    employee_id = models.CharField(max_length=15, unique=True)
```

And this `Department` model:

```python
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
print(person.user)
print(person.departments.all())

# No
person = Person.objects.first()              # hit database
print(person.first_name)
print(person.user)                           # hit database
print(person.departments.all())              # hit database
```

The second method seems short and easy to understand. But behind that, it hits database 3 times.

> **WARNING:** Calling `person.departments.filter(name='HR')` in both methods will hit database since it needs to query database to find the records which matched the given condition. `prefetch_related` does not help you in this situation.

## Using `.first()` Instead of Calling `.exists()` Followed by `.get()`

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
