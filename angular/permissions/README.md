# Permissions

After authenticated, we will get the authorized data from the server such as token, role, permission, etc., and store them in the authentication service or local storage for authorization in router and component.

## Service

Permission service helps you getting permission and role from the authored data stored.

First, you should define the model of permission that is got from the backend. For example,

```typescript
// permission.model.ts

export interface UserPermission {
  id: number;
  codename: string;
  app_label: string;
}
```

In the permission service, there are two important methods `findPermission` and `hasPermission`.

```typescript
// permission.service.ts

export class PermissionService {
  constructors(private authService: AuthenticationService) {}

  findPermission(codeName: string): UserPermission {
    if (!codeName) {
      throw new Error('No argument code name at hasPermission');
    }
    const userPermission = this.authService.currentUser;
    if (userPermission) {
      return userPermission.find(
        permission => permission.codename === codeName
      );
    } else {
      throw new Error('Missing user permission');
    }
  }

  hasPermission(codeName: string, actionType?: string): boolean {
    const permission = actionType ? actionType + '_' + codeName : codeName;
    try {
      return !!this.findPermission(permission);
    } catch (error) {
      return false;
    }
  }
}
```

Some accession may be used to check the role of a user such as `admin`. For convenience, you may use getter for checking the specific role from the stored data.

```typescript
export class PermissionService {
  ...

  get role(): boolean {
    return localStorage.getItem('role_name');
  }

  get isAdmin(): boolean {
    return this.role === 'admin';
  }
}
```

## Guard

Guard is used for protecting URL routes from unauthorized user. The main guard that is typically used, is `AuthGuard` which verifies authentication (there is in Authentication). However, in some routes, you may want to have more than one guard.

For example, this guard checks the user who has the `admin` role and the `view_memo` permission.
The `true` of returning will allow the page accession and if it isn't you can force to navigate to the default route by returning `URLTree`.

```typescript
// memo.guard.ts

@Injectable({
  providedIn: 'root',
})
export class MemoGuard implements CanActivateChild {
  constructor(private router: Router) {}

  canActivateChild(
    next: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): boolean {
    if (
      localStorage.getItem('currentUser') &&
      localStorage.getItem('role_name') === 'admin'
    ) {
      return true;
    }
    return this.router.parseUrl('/');
  }
}
```

```typescript
// app-routing.module.ts
export const routes: Routes = [
  {
    path: '',
    component: MainComponent,
    canActivate: [AuthGuard],
    children: [
      {
        path: 'memo',
        component: MemoComponent,
        canActivate: [MemoGuard],
      }
    ]
  },
];
```

See detail in <https://angular.io/guide/router> and <https://angular.io/guide/router-tutorial-toh>

## Component

To check permission, you must inject `PermissionService` in your component and call it in `ngOnInit()` or up to use them.

```typescript
export class Component implement OnInit {
  isApprove = false;

  constructor(private permission: PermissionService) {}

  ngOnInit() {
    this.isApprove = this.permission.hasPermission('approver');
  }
}
```

Applied permission to your template.

```html
<div class="example">
  <button *ngIf="isApprove">Approve</button>
  <button *ngIf="!isAdmin">Edit</button>
</div>
```
