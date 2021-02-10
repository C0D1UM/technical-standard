# Unit Test

## Fixtures

### Introduction

You should use fixtures if it's the kind of data that will be reusable. Example:

- Role
- Type

### Rules

Name of fixture should be noun in plural form.

```python
# Yes  
users.json  
people.json
departments.json

# No
do_something.json  # Not Noun
persons.json  # Incorrect grammar
```

One JSON fixture file for one model.

```json
# Yes
[
    {"model": "app.Model", "pk": 1, ...},
    {"model": "app.Model", "pk": 2, ...}
]

# No
[
    {"model": "app.Model1", "pk": 1, ...},
    {"model": "app.Model2", "pk": 1, ...}
]
```

Do not write your own fixtures, always generate from Django Admin command line.

```shell script
$ python manage.py dumpdata app.Model >> path/app/fixtures/model.json
```

If you have a set of fixtures can be reusable, consider creating a reusable constants.

```python
# Yes
## fixture_templates.py
USERS = [
    'users.json',
]

PEOPLE = USERS + [
    'people.json',
]

## tests.py
class UserTest(tests.TestCase):
    fixtures = fixture_templates.PEOPLE

# No
class UserTest(tests.TestCase):
    fixtures = [
        'users.json',
        'people.json',
    ]
```

## Factory Boy

### Introduction

### Rules

## Baker

### Introduction

### Rules

## Parallel Testing

Running test in parallel could speed up your test suite. [Read More](https://docs.djangoproject.com/en/3.1/ref/django-admin/#cmdoption-test-parallel)

If you are using test coverage, make sure to run combine after run the coverage:

```shell script
$ coverage run
$ coverage combine
$ coverage report -m
```
