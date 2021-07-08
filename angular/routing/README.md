# Routing

Best practices for routing.

# Handle Not Found URL

Always add not found view to handle not found url.

```typescript
const routes: Routes = [
  {path: '**', component: NotFoundComponent}
]
```

## Feature Separated

You shouldn't having all component in one routing, you should split into modules
dictated by feature. And also this would help you separate on view that need
navbar and some views that doesn't need navbar.

```typescript
// No
const routes: Routes = [
  {path: 'dashboard', component: DashboardComponent},
  {path: 'tasks', component: TaskComponent},
  {path: 'login', component: LoginComponent},
  {path: '**', component: NotFoundComponent}
]

// Yes
// main-routing.module.ts
const mainRoutes: Routes = [
  {path: 'dashboard', component: DashboardComponent},
  {path: 'tasks', component: TaskComponent},
]

// app-routing.modules.ts
const routes: Routes = [
  {path: 'views', children: mainRoutes},
  {path: 'login', component: LoginComponent},
  {path: '**', component: NotFoundComponent},
]
```

## Lazy Loading

Lazy loading help to split your application to smaller chunks and load only when
requested, not the whole app at once. [Learn More](https://angular.io/guide/lazy-loading-ngmodules)

```typescript
export const routes: Routes = [
  {path: 'feature-a', loadChildren: './views/feature-a/feature-a.module#FeatureA'},
  {path: 'feature-B', loadChildren: './views/feature-a/feature-a.module#FeatureB'}
]
```

## Use Guard

For specific view that required permission use guard. [Learn More](https://angular.io/api/router/CanActivate)

### Group Guard

Group guards into one `guards` directory. Shared guard should in `shared` directory
and specific guard for feature should be in it's own module.

```script
app/
---/shared
----------/guards
---/views
----------/road-map
-------------------/guards
```

### Use Barrel Exports

Use barrel exports to make your calling to guard more clean. Example in `guards` directory
create a new field `index.ts`, then add export code as below:

```typescript
// guards/index.ts
export * from './admin.can-activate.guard';
export * from './other.can-deactivate.guard';
```

Then when import we can do this:

```typescript
import {AdminCanActivateGuard, OtherCanDeactivateGuard} from 'scr/app/shared/guards';
```

But without barrel export we will need to:

```typescript
import {AdminCanActivateGuard} from 'src/app/shared/guards/admin.can-activate.guard';
import {OtherCanDeactivateGuard} from 'src/app/shared/guards/other.can-deactivate.guard';
```
