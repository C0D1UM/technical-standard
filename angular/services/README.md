# Services

This page will give you some practices and tips/tricks about Angular services.

# Components should only deal with display logic

Components are designed for presentation of view. Business logic should be extracted into Service. Business logic is usually easier to unit test when extracted out to a Service, and can be reused too.


# Limit Usage of Service Class

If you want your Service to be available in whole project. You can use `providedIn: 'root'`

```ts
// Use "providedIn: 'root'" to let Angular import this service to all modules in your project.
@Injectable({
  providedIn: 'root',
})
export class UserService {
    ...
}
```

set `providedIn` to module if you want your Service to be available in some module.

```ts
// Option1. Set 'providedIn' to module and Angular will import Service to that module for you.
import { SomeModule } from './some.module';

@Injectable({
  providedIn: SomeModule,
})
export class UserService {
    ...
}

// Option2: you manually import Service to your module.ts file
import { UserService } from './user.service';

@NgModule({
  providers: [UserService],
})
export class SomeModule {
    ....
}
```

# Shorten Service Import by using Alias

tsconfig.json can config alias path which can shorten your import statement.

```ts
{
  "compilerOptions": {
    ...
    "paths": {
      "@app/*": ["app/*"],
      "@env/*": ["environments/*"]
    }
  }
}
```

After that, you can shorten import of Services, Modules, Components, etc.
```ts
// equal to '../../../loader/loader.service';
import { LoaderService } from '@app/loader/loader.service';

// equal to '../../environment’;
import { environment } from '@env/environment’;
```
