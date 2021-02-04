# Model

Best practices for creating model class.

## Table of Contents

- [Common](#common)
- [Fields](#fields)
- [Model Controller](#model-controller)
- [Managers](#managers)

## Common

These are some of the best practices that you should add to your model class.

### The String Representation Function

By default django will use id when we try to print the object.

```python

obj = Model.objects.first()
print(obj)
>>> <Model: (1)>
```

It's easier to debug when you get more information regarding the object.

```python
class Person(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    position = models.ForeignKey(
        to='people.Position',
        on_delete=models.CASCADE,
        related_name='people',
    )

    # String function that you should add
    def __str__(self):
        return f'{self.first_name} {self.last_name}'
```

When trying to debug:

```python
person = Person.objects.first()
print(person)
>>> <Person: Khemanorak Khath>
```

**CAUTION**: You should not use foreign key field in your string function,
because this could lead to performance problem.

```python
# No
def __str__(self):
    return f'{self.first_name} {self.last_name} {self.position.name}'

# If your query is not select_related position, this will hit database
# with the amount of people.
```

## Fields

Best practices when defining field in model.

### Naming

- Field name should be **noun** and in **singular** form, except
for many-to-many field should be **plural** form.
- Boolean field should be **verb** with past tense.
- Do not repeat model name in field name.
- Related name parameter value should be **plural** form.

```python
class Person(models.Model):
    # Yes: Singular noun
    first_name = models.CharField(max_length=100)
    # No : Repeat model name person
    person_first_name = models.CharField(max_length=100)
    
    # Yes: Many to Many in plural form
    companies = model.ManyToMany(to='company.Company', blank=True, related_name='people')

    # Yes
    activated = models.BooleanField()
    # No
    is_active = models.BooleanFiled()
```

### Relationship

- When defining foreign key, one to one or many to many in a model it should be
lazy reference instead of importing the model class directly, preventing
circular or recursive import exception.
[Read more](https://docs.djangoproject.com/en/3.1/ref/models/fields/#foreignkey)
- Always add related name parameter to foreign key or many to many field. If you
don't want Django to create backward relation add '+' to the `related_name` parameter.

```python
# Yes
class Employee(models.Model):
    # Create backward relation
    person = models.ForeignKey(to='people.Person', on_delete=models.CASCADE, related_name='employees')
    # Do not create backward relation
    person = models.ForeignKey(to='people.Person', on_delete=models.CASCADE, related_name='+')

# No
from people.models import Person
class Employee(models.Model):
    person = models.ForeignKey(to=Person, on_delete=models.CASCADE)
```

### Related Name

By default the related name of a relationship field is `{field_name}_set`,
so by adding `related_name` parameter make the code cleaner and more readable.

```python
# Yes
class Employee(models.Model):
    person = models.ForeignKey(
        to='people.Person',
        on_delete.CASCADE,
        related_name='employees'
    )

person = Person.objects.first()
person.employees.all()

# No
class Employee(models.Model):
    person = models.ForeignKey(to='people.Person', on_delete.CASCADE)

person = Person.objects.first()
person.employee_set.all()
```

## Model Controller

Model Controller is a third party library that we use to keep track of data
in each row, sometimes we would like to know when this row was create or
update or who create or update this row.

For installation and setup
[read here](https://github.com/NorakGithub/django-model-controller) <sup>1</sup>

```python
from model_controller.models import AbstractSoftDeletionModelController


class Person(AbstractSoftDeletionModelController):
    pass
```

With this abstract class you get 5 fields:

- `alive`: instead of delete row from database we just change the `alive` field to `null`, so that we can recover this row later.
- `created_user/updated_user`: these fields are foreign key to `User` model. If you are using `ModelControllerSerializer` it will automatically add these field for you.
- `created_at/updated_at`: these fields store the datetime fields when the record was created or latest update.

Two important things you need to know after extended
`AbstractSoftDeletionModelController`:

- It overwrite the `delete()` method so that when you call delete method in your model object it will update `alive = null` instead of actually delete the object.
- It provided you with two managers `objects` and `all_objects`

```python
# This will return person that alive is true
Person.objects.all()

# This will return all person rows in database include alive is null
Person.all_objects.all()
```

### Unique

When using `AbstractSoftDeletionModelController` if you want to make field value
unique, make sure you use `unique_together` with `alive` field instead of
field unique. Use `UniqueConstraint` with Django >= 2.0.

```python
# Yes
class Person(AbstractSoftDeletionModelController):
    username = model.CharField(max_length=100)

    class Meta:
        # Django <= 1.9
        unique_together = ('username', 'alive')
        # Django >= 2.0
        constaints = (
            models.UniqueConstraint(fields=('username', 'alive'), name='unique-username')
        )


# No
class Person(AbstractSoftDeletionModelController):
    username = models.CharField(max_length=100, unique=True)
```

By using `unique_together` it allow you to create only 1 record if it's alive,
you can recreate the same object if `alive is null`.

**FAQ:** Why we set alive to null instead of false when delete?

| id | username | alive |
| -- | -------- | ----- |
| 1  | sample   | false |
| 2  | sample   | fasle |

If you are using unique together, this case is not possible because data with id
1 is already exists.

| id | username | alive |
| -- | -------- | ----- |
| 1  | sample   | null  |
| 2  | sample   | null  |

This case is possible because database will ignore null field.

## Managers

This is where you add reusable query, it make query more maintainable and
readable.

If you are using `AbstractSoftDeletionModelController` make sure to extend
your manager from `SoftDeletionManager`.

```python
from model_controller.managers import SoftDeletionManager


class PersonManager(SoftDeletionManager):
    
    def get_with_employees(self):
        query = self.get_query()
        return query.prefetch_related('employees')
```

Register to your model

```python
class Person(AbstractSoftDeletionModelController):
    ...
    objects = PersonManager()
```

Example usage

```python
people = Person.objects.get_with_employees()
```

### Reference

- [Official Doc](https://docs.djangoproject.com/en/3.1/topics/db/managers/)
- [Project Structure](django/project-structure/README.md)
(where should your manager be)

___
<sup>1</sup> *At the time of writting, the latest version is
`django-model-controller==0.4.2`*.
