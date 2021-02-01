# ModelViewset

## Basic ModelViewSet
Basic usage of ModelViewset is to define 2 objects
 * queryset - database query for your model
 * serializer_class - class for converting model query into JSON string.

```py
from rest_framework.viewsets import ModelViewSet

class MyViewSet(ModelViewSet):
    # define queryset. 
    queryset = myModel.objects.all()

    # define serializer.
    serializer_class = myModelSerializer
```

## Skip Authenitcation Checking
Use AllowAny if you want to skip authentication checking.
```py
class MyViewSet(ModelViewSet):
    # Use AllowAny if you want to skip authentication checking.
    permission_classes = (AllowAny,)

    # or use None to skip authentication checking.
    permission_classes = None
```

## Customize Seriailizer
If you want difference serializer for GET/POST request, you can following attribute instead of setting in `get_serializer_class` function.
 * list_serializer_class - for GET request
 * retrieve_serializer_class - for GET request with item ID
 * write_serializer_class - for POST request

```py
# Good:
class MyViewSet(ModelViewSet):
    # define serializer for GET request
    list_serializer_class = myModelListSerializer

    # define serializer for GET request with item ID
    retrieve_serializer_class = myModelDetailSerializer

    # define serializer for POST request
    write_serializer_class = myModelWriteSerializer


# Bad:
class MyViewSet(ModelViewSet):
    serializer_class = myModelSerializer

    def get_serializer_class(self):
        serializer = super().get_serializer_class()

        if self.request.method == 'GET':
            if self.kwargs.get('pk'):
                return myModelDetailSerializer
            else:
                return myModelListSerializer
        elif self.request.method == 'POST':
            return myModelWriteSerializer
        else
            return serializer
```


## Use Django Built-in FilterClass/Ordering
for simple search/filter/ordering, use Django built-in filterClass. It is easier than implmenting in `get_queryset` function
To setup, `pip install django-filter`. Then add `'django_filters'` to Django's `INSTALLED_APPS`

```py
# Good:
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters
class MyViewSet(ModelViewSet):
    filter_backends = [filters.SearchFilter, DjangoFilterBackend, filters.OrderingFilter]

    # DjangoFilterBackend used for equality filter.
    #   Ex. localhost:8000/api/department/?name=ABC 
    #      it will search for name='ABC'
    #   Ex. localhost:8000/api/department/?name_en=ABC 
    #      it will search for name_en='ABC'
    filterset_fields = ['name', 'name_en']

    # SearchFilter used for search multiple fields at once. 
    # Ex. localhost:8000/api/department/?search=ABC 
    #    it will search for field 'name' contains 'ABC' or 'name_en' contains 'ABC'
    search_fields = ['name', 'name_en', ]


    # OrderingFilter used for controlling order results.
    # Ex. localhost:8000/api/department/?ordering=account,-username
    #     it will order by account ascending, then username descending
    ordering_fields = ['username', 'account']
    # set default ordering.
    ordering = ['username']


# Bad:
class MyViewSet(ModelViewSet):
    def get_queryset(self):
        queryset = super().get_queryset()
        
        name = self.request.GET.get('name')
        if name:
            queryset = queryset.filter(name=name)

        name_en = self.request.GET.get('name_en')
        if name_en:
            queryset = queryset.filter(name_en=name_en)

        search = self.request.GET.get('search')
        ...

        ordering = self.request.GET.get('ordering')
        ...

        return queryset

```

## Use Custom FilterClass
In case that Django Built-In FilterClass does not meet with your requirements. You can create your own FilterClass and set in ModelViewset below.
```py
class MyViewSet(ModelViewSet):
    # define filterclass
    filter_class = myModelFilter

    def get_queryset(self):
        #
        # In case you want to modify queryset. 
        # This function will be called before queryset goes to FilterClass
        #
        queryset = super().get_queryset()
        
        #
        # do something here. Ex. You can add .select_related() to queryset in some conditions.
        # 
        if some_conditions:
            queryset = queryset.select_related('...')
        
        return queryset
```