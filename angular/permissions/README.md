# Permissions

<!-- After you get user information from the data store.

you should collect permission in the permission service.

For handling permission, we can use service, guard to help allowance in component. -->

## Service

The permission service help you about finding role and getting permission from the stored user data.

First, you should define the model of permission that is got from backend. For example,

```typescript
// permission.model.ts

export interface UserPermission {
  id: number;
  codename: string;
  app_label: string;
}
```

In permission service there are two important method about permission is `findPermission` and `hasPermission`.

```typescript
// permission.service.ts

export class PermissionService {
  ...

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

Some accession maybe used checking the role of user such as `admin`. For convenience, you may use getter for checking role from the stored data.

```typescript
export class PermissionService {
  ...
  get isAdmin(): boolean {
    return localStorage
  }
}
```

## Guard

Guard is used for protecting url route from unwanted user to access them. You might make a guard for some purpose.

For example, This guard check the user the `admin` role and the `view_memo` permission. The `true` of returning will allow the page accession and if it isn't we will navigate to default route.

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
    this.router.navigate(['']);
    return false;
  }
}
```

Add the guard to terminal in routes.

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

## Component

To check permission you must inject `PermissionService` in your component and call it in `OnInit()` or depend on to use them.

```typescript
export class Component implement OnInit {
  isApprove = false;

  constructor(private permission: PermissionService) {}

  ngOnInit() {
    this.isApprove = this.permission.hasPermission('approver');
  }
}
```

Applied permission to your HTML.

```html
<div class="">
  <button *ngIf="isApprove">Approve</button>
  <button *ngIf="!isAdmin">Edit</button>
</div>
```
