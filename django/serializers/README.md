# Serializers

## Model Serializer

Basic usage of ModelSerializer

* Need to provide one of the attributes `fields` or `exclude`
* If you need to write some custom fields, check [Third party packages](https://www.django-rest-framework.org/api-guide/serializers/#third-party-packages) first

```python
# serializers.py
from res_framework import serializers

# Yes
class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['id', 'account_name', 'users', 'created']

# Yes
class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = '__all__'

# Yes
class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        exclude = ['users']
```

### ModelControllerSerializer

If your model extends from `AbstractModelController` use `ModelControllerSerializer`

```python
# serializers.py
from model_controller import serializers as mc_serializers
from res_framework import serializers


# Yes 
class AccountSerializer(mc_serializers.ModelControllerSerializer):
    pass

# No
class AccountSerializer(serializers.ModelSerializer):
    def create(self, validated_data):
        user = self.context['request'].user

        validated_data['created_user'] = user
        validated_data['updated_user'] = user

        return super().create(validated_data)

    def update(self, instance, validated_data):
        user = self.context['request'].user

        validated_data['updated_user'] = user

        return super().update(instance, validated_data)
```

## Fields

### SerializerMethodField

SerializerMethodField is a read only field that computes its value at request processing time.
Be careful, always use `prefetch_related` or `select_related` on the queryset when it's hit the database.
Sometimes you might not need this. If it's just a property of object you can use `source` instead.

```python
# serializers.py
from rest_framework import serializer

# Yes
class ProfileSerializer(serializers.ModelSerializer):
    username = serializers.CharField(source='user.username')

# No
class ProfileSerializer(serializers.ModelSerializer):
    username = serializers.SerializerMethodField()

    def get_age(self, obj):
        return obj.username

```

### HiddenField

Use [HiddenField](https://www.django-rest-framework.org/api-guide/fields/#hiddenfield) to provide a predefined value

```python
from django.utils import timezone
from rest_framework import serializers

# Yes
class EmailSerializer(serializers.ModelSerializer):
    modified = serializers.HiddenField(default=timezone.now)

# No
class EmailSerializer(serializers.ModelSerializer):
    def create(self, validated_data):
        validated_data['modified'] = timezone.now()
        return super().create(validated_data)
    
    def update(self, instance, validated_data):
        validated_data['modified'] = timezone.now()
        return super().create(instance, validated_data) 

```

## CreateOnlyDefault

Use [CreateOnlyDefault](https://www.django-rest-framework.org/api-guide/validators/#createonlydefault) to set a default argument during create operations

```python
from rest_framework import serializers

# Yes
class EmailSerializer(serializers.ModelSerializer):
    owner = serializers.CreateOnlyDefault(default=serializers.CurrentUserDefault())

# No
class EmailSerializer(serializers.ModelSerializer):
    def create(self, validated_data):
        owner = self.context['request'].user
        return super().create(validated_data))

```


## Validation

### Field level Validation

### Object level validation
