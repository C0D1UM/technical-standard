# Interceptors

Example usage of interceptors in your application

## HTTP Interceptors

1. Always use HTTP Interceptor over wrapped Angular built-in HTTP class
1. All interceptors file name should end with `interceptor.ts` eg. `authentication.interceptor.ts`

### Example use cases

* Add Authentication token to HTTP requests
* Manipulating the URL eg. append '/' into the URL
* Check if the user token is expired
* Cache HTTP responses

### Example JWT Interceptor

app.module.ts

```ts
 ...
import { HTTP_INTERCEPTORS } from '@angular/common/http';
import { AuthenticationInterceptor } from '...';
@NgModule({
  ...
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthenticationInterceptor
    },
   ...
  ],
  ...
})
export class AppModule { }
```

authentication.interceptor.ts

```ts
import {Injectable} from '@angular/core';
import {HttpEvent, HttpHandler, HttpInterceptor, HttpRequest} from '@angular/common/http';
import {Observable} from 'rxjs';

@Injectable()
export class AuthenticationInterceptor implements HttpInterceptor {
  constructor(private authenticationService: AuthenticationService) {
  }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const isLoggedIn = // do stuff to check user is logged in

    if (isLoggedIn) {
      const accessToken = // get user access token
      request = request.clone({
        setHeaders: {
          Authorization: `Bearer ${accessToken}`
        }
      });
    }

    return next.handle(request);
  }
}
```
