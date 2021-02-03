# Model

Best practices for creating your model
## Table of Contents

- Common
- Fields
- Model Controller
- Managers
## Common

These are some of the best practices that you should add to your model class.

### The String Representation Function

By default django will use id when we try to print the object.
```python
obj = Model.objects.first()
print(obj)
>>> <Model: 1>
```

It's easier to debug when you get more information regarding the object.
```python
class Person(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)

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

## Fields

Best practices when defining field in model.

### Naming

- Field name should be **noun** and in **singular** form, except for many-to-many field should be **plural** form.
- Use past tense with boolean field.
- Do not repeat model name in field name.
- Related name parameter value should be **plural** form.

```python
class Person(models.Model):
    # Yes: Signular noun
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
### Relationship Fields

- When defining foreign key in a model you should use lazy reference instead of importing the model class directly, 
preventing recursive import exception. [Read more](https://docs.djangoproject.com/en/3.1/ref/models/fields/#foreignkey)
- Always add related name parameter to foreign key or many to many field.
```python
# Yes
class Employee(models.Model):
    person = models.ForeignKey(to='people.Person', on_delete=models.CASCADE, related_name='employees')

# No
from people.models import Person
class Employee(models.Model):
    person = models.ForeignKey(to=Person, on_delete=models.CASCADE)
```

#### Related Name

By default the related name of a relationship field is `{field_name}_set`, so by adding `related_name` parameter make the code cleaner and more readable.
```python
person = Person.objects.first()

# Yes: With related name
person.employees.all()

# No : Without related name
person.employee_set.all()
```

## Model Controller
Model is a third party library that we use to keep track of data in each row, sometimes we would like to know when this row was create or update or who create or update this row.
## Managers
