# ViewSets

## ModelViewset

### Basic ModelViewSet

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

### Skip Authenitcation Checking

Use AllowAny if you want to skip authentication checking.

```py
class MyViewSet(ModelViewSet):
    # Use AllowAny if you want to skip authentication checking.
    permission_classes = (AllowAny,)
```

### Customize Seriailizer

If you want different serializer for GET/POST request, you can use following attribute:

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

### Use Django Built-in FilterClass/Ordering

For simple search/filter/ordering, use Django built-in FilterClass. To setup, run `pip install django-filter`. Then add `'django_filters'` to Django's `INSTALLED_APPS`

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

### Use Custom FilterClass

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

### Customize HTTP Method

You should limit http method that user can call to the server. ModelViewset will enable all methods by default.

```py
# Good
class MyViewSet(ModelViewSet):
    queryset = myModel.objects.all()
    serializer_class = myModelSerializer
    http_method_names = ['get', 'head', 'post', 'patch']

# Bad
class MyViewset(ModelViewSet):
    queryset = myModel.objects.all()
    serializer_class = myModelSerializer

    def get_queryset(self):
        if not self.request.method in ['GET', 'POST', 'PATCH']:
            raise Exception('method invalid')
        else
            return super().get_queryset()
```

### ReadOnlyModelViewset

Use ReadonlyModelViewset if you want request in GET only.

```py
# Good
class MyViewSet(ReadOnlyModelViewSet):
    queryset = myModel.objects.all()
    serializer_class = myModelSerializer


# Bad
class MyViewSet(ModelViewSet):
    queryset = myModel.objects.all()
    serializer_class = myModelSerializer
    http_method_names = ['get', 'head']
```

## APIView

Use APIView if request does not specifically belongs to some model. Use JsonResponse or Response instead of HttpResponse

```py
# Good
from django import http
class UserViewSet(views.APIView):
    def get(self, request):
        return http.JsonResponse({
            'users': 123,
        })

# Good
from rest_framework.response import Response
class UserViewSet(views.APIView):
    def get(self, request):
        return Response(data={
            'users': 123,
        })

# Bad
class UserViewSet(views.APIView):
    def get(self, request):
        response_json_str = json.dumps({
            'users': 123,
        })
        return http.HttpResponse(response_json_str, content_type="application/json", status=200)

```

Use HttpResponseStatus instead of status number

```py
# Good
from rest_framework import status
class UserViewSet(views.APIView):
    def get(self, request):
        return Response(data={}, status=status.HTTP_200_OK)

# Bad
class UserViewSet(views.APIView):
    def get(self, request):
        return Response(data={}, status=200)

```
