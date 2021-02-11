# Unit Test

## Common Best Practices

- If you don't know what are the unit test for your function should be, try not
to use other testing tools like, Browser or Postman etc. The only tool to test
if your code run correctly is unit test.
- If the test is for Django Model, Form or View etc, use `django.test.TestCase`.
- If the test is for Django REST, use `rest_framework.test.APITestCase`.
- Test must be isolated, it must not required other test case to pass.
- Test must not required to run in sequential.
- Test function name should tell what intended to do and the reason why it failed or passed.

```python
# Yes
def test_create_person_should_fail_when_name_is_already_existed(self):
    ...

# No
def test_api(self):
    ...
```

- Show more information when assertion failed, easy for debugging.

```python
# Yes
def test_create_person_should_success(self):
    res = self.client.post(url, data)
    self.assertEqual(res.status, HTTP_201_CREATED, res.json())

# No
def test_create_person_should_success(self):
    res = self.client.post(url, data)
    self.assertEqual(res.status, HTTP_201_CREATED)
```

- Use `setUp` method to create a sharable data in the current test suite.
- Do not hardcoded url, use `reverse` instead.

```python
class TestSimple(TestCase):
    def setUp(self):
        self.user = User.objects.get(id=1)
        # Yes
        self.url = reverse('api:person')
        # No
        self.url = '/api/person/'
    
    def test_something_should_be_succeed(self):
        self.url ...
        self.user ...
    
    def test_something_should_be_failed(self):
        self.url ...
        self.user ...
```

- Use Django Build-in assertion instead of python assertion, because it provided
more information when assertion failed.

```python
class TestSimple(TestCase):
    def test_something_should_be_failed(self):
        # Yes
        self.assertIsNotNone(...)
        self.assertIsNone(...)
        self.assertTrue(...)
        self.assertFalse(...)
        self.assertEqual(...)
        # No
        assert a is not None
        assert b is None
        assert a == True
        assert b == False
        assert a == b
```

- You don't have to coverage 100% of unit test, but you must at least sure that
your code work as intended.
- Do not write unit test for third-party packaged or framework you are using,
because it should already have its own unit test.

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

class PersonTest(tests.TestCase):
    fixtures = fixture_templates.PEOPLE

# No
class UserTest(tests.TestCase):
    fixtures = [
        'users.json',
        'people.json',
    ]

class PersonTest(tests.TestCase):
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
