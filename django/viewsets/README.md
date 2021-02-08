# ModelViewset

## Basic ModelViewSet

Basic usage of ModelViewset is to define 2 objects

* queryset - database query for your model
* serializer_class - class for converting model query into JSON string.

```py
from rest_framework.viewsets import ModelViewSet

class MyViewSet(ModelViewSet):
    # define queryset. 
    queryset = MyModel.objects.all()

    # define serializer.
    serializer_class = MyModelSerializer
```

## Skip Authentication Checking

Use AllowAny if you want to skip authentication checking.

```py
class MyViewSet(ModelViewSet):
    # Use AllowAny if you want to skip authentication checking.
    permission_classes = (AllowAny,)
```

## Customize Serializer

If you want different serializer for GET/POST request, you can use following attribute:

* list_serializer_class - for GET request
* retrieve_serializer_class - for GET request with item ID
* write_serializer_class - for POST request

```py
# Good:
class MyViewSet(ModelViewSet):
    # define serializer for GET request
    list_serializer_class = MyModelListSerializer

    # define serializer for GET request with item ID
    retrieve_serializer_class = MyModelDetailSerializer

    # define serializer for POST request
    write_serializer_class = MyModelWriteSerializer


# Bad:
class MyViewSet(ModelViewSet):
    serializer_class = MyModelSerializer

    def get_serializer_class(self):
        serializer = super().get_serializer_class()

        if self.request.method == 'GET':
            if self.kwargs.get('pk'):
                return MyModelDetailSerializer
            else:
                return MyModelListSerializer
        elif self.request.method == 'POST':
            return MyModelWriteSerializer
        else
            return serializer
```

## Use Django Built-in FilterClass/Ordering

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

    # SearchFilter used for searching multiple fields at once. 
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


## Viewset Actions
You can create custom url for viewset by using `@action` decorator. It is better than creating separated APIViews.


```py
class MyViewset(viewsets.ModelViewSet):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer

    @action(detail=False, methods=['GET'], url_name='my_reverse_url_name', url_path='my_url_path')
    def my_custom_viewset_action(self, request):
        # do something ...
        return Response( ... )
```

Then, in your api_urls.py
```py
router.register(r'my-viewset', MyViewset)
```

You can call GET `localhost:8000/my-viewset/my_url_path/` which Django will call function `my_custom_viewset_action`


If you set `detail=True` in action parameters, you need to add `pk` parameter in your action function. 

```py
@action(detail=True, methods=['GET'], url_name='my_reverse_url_name', url_path='my_url_path')
def my_custom_viewset_action(self, request, pk):
    # do something ...
    return Response( ... )
```
For example: calling GET `localhost:8000/my-viewset/10/my_url_path/` which Django will call function `my_custom_viewset_action` with parameter `pk=10`



## Use Custom FilterClass

In case that Django Built-In FilterClass does not meet your requirements. You can create your own FilterClass and set it in ModelViewset below.

```py
class MyViewSet(ModelViewSet):
    # define filterclass
    filter_class = MyModelFilter

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

## Customize HTTP Method

You should limit http method that user can call to the server. ModelViewset will enable all methods by default.

```py
# Good
class MyViewSet(ModelViewSet):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer
    http_method_names = ['get', 'head', 'post', 'patch']

# Bad
class MyViewset(ModelViewSet):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer
    
    def get_queryset(self):
        if not self.request.method in ['GET', 'POST', 'PATCH']:
            raise Exception('method invalid')
        else
            return super().get_queryset()
```

## Generic Views

### ReadOnlyModelViewSet
Use ReadonlyModelViewset if you want request in GET and GET with item id only.

```py
# Good
class MyViewSet(ReadOnlyModelViewSet):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer


# Bad
class MyViewSet(ModelViewSet):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer
    http_method_names = ['get', 'head']
```

### Other Generic Views
Moreover, there are many generic views as follows
| Generic View Class           | GET (Listing) | GET (item ID) | POST | PUT/PATCH | DELETE |
|------------------------------|---------------|---------------|------|-----------|--------|
| CreateAPIView                |               |               |   *  |           |        |
| ListAPIView                  |       *       |               |      |           |        |
| RetrieveAPIView              |               |       *       |      |           |        |
| DestroyAPIView               |               |               |      |           |    *   |
| UpdateAPIView                |               |               |      |     *     |        |
| ListCreateAPIView            |       *       |               |   *  |           |        |
| RetrieveUpdateAPIView        |               |       *       |      |     *     |        |
| RetrieveDestroyAPIView       |               |       *       |      |           |    *   |
| RetrieveUpdateDestroyAPIView |               |       *       |      |     *     |    *   |


# APIView

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
