# Permissions

* Keep permissions inside `permissions.py`
* Check [third-party packages](https://www.django-rest-framework.org/api-guide/permissions/#third-party-packages) before writing your own permission classes
* Function-based views will need to check object permissions explicitly by calling `.check_object_permissions(request, obj)`, raising `PermissionDenied` on failure.

## Default permission policy

Always provide the default permission classes in `settings.py`

```python
# settings.py

REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ]
}
```

## Example permission class

```python
# permissions.py

from rest_framework import permissions


class ReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.method in permissions.SAFE_METHODS

```

## Compose permissions

Many permission classes can be composed Python bitwise operators.
*Note: It supports `&` (and), `|` (or) and `~` (not).*

```python
# views.py

from rest_framework import permissions
from rest_framework import response
from rest_framework import views

class ExampleView(views.APIView):
    permission_classes = [permissions.IsAuthenticated|permissions.ReadOnly]

    def get(self, request, format=None):
        content = {
            'status': 'request was permitted'
        }
        return response.Response(content)

```

## View level permission

Example

```python
# permissions.py

from rest_framework import permissions

class BlocklistPermission(permissions.BasePermission):
    """
    Global permission check for blocked IPs.
    """

    def has_permission(self, request, view):
        ip_addr = request.META['REMOTE_ADDR']
        blocked = Blocklist.objects.filter(ip_addr=ip_addr).exists()
        return not blocked
```

## Object level permission

For clarification, use `has_object_permission` over `has_permission` as in [View level permission](#view-level-permission).

```python
# permissions.py

# Yes
class IsOwnerOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):

        if request.method in permissions.SAFE_METHODS:
            return True

        return obj.owner == request.user


# No
class IsOwnerOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        obj = view.get_object()

        if request.method in permissions.SAFE_METHODS:
            return True

        return obj.owner == request.user

```
