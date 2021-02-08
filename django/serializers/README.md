# Serializers

## Model Serializer

Basic usage of ModelSerializer

* Need to provide one of the attributes `fields` or `exclude`
* Prefer to use [Third party packages](https://www.django-rest-framework.org/api-guide/serializers/#third-party-packages) instead of writing on your own
* Use `select_related` and `prefetch_related` to improve queries performance

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

If it's just a property of object you can use `source` instead

```python
# serializers.py
from rest_framework import serializer

# Yes
class ProfileSerializer(serializers.ModelSerializer):
    username = serializers.CharField(source='user.username')

# No
class ProfileSerializer(serializers.ModelSerializer):
    username = serializers.SerializerMethodField()

    def get_username(self, obj):
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

* Prefer to use [DRF Validators](https://www.django-rest-framework.org/api-guide/validators/) over custom validation functions

### Field level Validation

Your `validate_<field_name>` methods should return a validated value or raise `serializers.ValidationError`

```python
from rest_framework import serializers

# Yes
class BlogPostSerializer(serializers.Serializer):
    title = serializers.CharField(max_length=100)
    content = serializers.CharField()

    def validate_title(self, value):
        if 'django' not in value.lower():
            raise serializers.ValidationError("Blog post is not about Django")
        return value


# No 
class BlogPostSerializer(serializers.Serializer):
    title = serializers.CharField(max_length=100)
    content = serializers.CharField()

    def validate_title(self, value):
        if 'django' not in value.lower():
            raise ValueError("Blog post is not about Django")
        return value
```

### Object level validation

Do not manipulate the data while doing object level validation

```python
from rest_framework import serializers

# Yes
class EventSerializer(serializers.Serializer):
    description = serializers.CharField(max_length=100)
    start = serializers.DateTimeField()
    finish = serializers.DateTimeField()

    def validate(self, data):
        if data['start'] > data['finish']:
            raise serializers.ValidationError("finish must occur after start")
        return data

# No
class EventSerializer(serializers.Serializer):
    description = serializers.CharField(max_length=100)
    start = serializers.DateTimeField()
    finish = serializers.DateTimeField()

    def validate(self, data):
        data['description'] = 'some description'
        if data['start'] > data['finish']:
            raise serializers.ValidationError("finish must occur after start")
        return data
```
