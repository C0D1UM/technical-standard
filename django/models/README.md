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
