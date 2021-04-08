# Permissions

<!-- After you get user information from the data store.

you should collect permission in the permission service.

For handling permission, we can use service, guard to help allowance in component. -->

## Service

The permission service help you about finding role and getting permission from data is stored.

```typescript
export class PermissionService {
  ...
  hasPermission(codeName: string): boolean {
    ...
  }
}
```

For some checking permission is often used as admin. We will make getter for checking them only.

```typescript
export class PermissionService {
  ...
  get isAdmin(): boolean {
    ...
  }
}
```

## Guard

For protecting user from unwanted route, we use guard. You might make a guard for some purpose.

```typescript

```

Add the custom guard to terminal in routes.

```typescript

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
