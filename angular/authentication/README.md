# Authentication Guidelines

## Refresh Token

### Main Component

By default, backend will set default token expiration time = 1 month. So, On frontend, The easiest way is just refreshing token every time when user refresh website. You can do by add code below in your `main.component.ts`

```ts
export class MainComponent implements OnInit {
    ngOnInit() {
        // call refresh token API
        this.authService.refreshToken({refresh: localStorage.refresh}).subscribe(
            (data: Token) => {
                // save token and user information to local storage.
                localStorage.setItem('currentUser', data);
            },
            (error) => {
                // if error occurs, you may use old token and do nothing.
                return;

                // or redirect to login page.
                // this.router.navigate(['/login']);
            }
        );
    }
}
```

### (Optional) Short Expiration Time

If token time is very short (Ex. Banking website which token is expired in 5 minutes), You must check token expiration time before call request and refresh token if needed. See code below.

```ts
function refreshTokenIfExpired () {
    // decode jwt token. This is very technical, you can skip this part of code.
    let base64Url = localStorage.currentUser.split('.')[1];
    let base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    let jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));

    let decoded = JSON.parse(jsonPayload);
    const now = Date.now().valueOf() / 1000

    let refreshToken = false
    // check if token will be expired in 5 minutes (300000 = 5 minutes)
    let FIVE_MINUTES = 5 * 60 * 1000;
    if (typeof decoded.exp !== 'undefined' && decoded.exp < now - FIVE_MINUTES) {
        refreshToken = true
    }
    if (typeof decoded.nbf !== 'undefined' && decoded.nbf > now - FIVE_MINUTES) {
        refreshToken = true
    }

    // call refresh token if it is nearly expired.
    if (refreshToken) {
        this.authService.refreshToken( ... )
    }
};
```

# Authentication Token Interceptor

Authentication token interceptor which will add token to request.

```ts
import {Injectable} from '@angular/core';
import {HttpEvent, HttpHandler, HttpInterceptor, HttpRequest} from '@angular/common/http';
import {Observable} from 'rxjs';

import {environment} from '../../../environments/environment';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {
  constructor(private authenticationService: AuthenticationService) {
  }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    // add auth header with jwt if user is logged in and request is to the api url
    const currentUser = localStorage.currentUser;
    const isApiUrl = request.url.startsWith(environment.baseUrl);

    if (currentUser && isApiUrl) {
      request = request.clone({
        setHeaders: {
          Authorization: `Bearer ${currentUser}`
        }
      });
    }

    return next.handle(request);
  }
}
```

# LocalStorage

LocalStorage size is limited to about 5MB. Make sure that you don't save large files (Ex. profile pictures). You should download file from backend server instead.

```
# Bad. Do not save files data into localstorage. Size limit is about 5 MB.
let bytes = .... 
localStorage.setItem('file', bytes)
```

## LocalStorage VS SessionStorage

You should not save user profile into SessionStorage. Different between LocalStorage and SessionStorage is below.

* LocalStorage will save data and share that data when user open 2 tabs.
* SessionStorage will not share data when across tabs.
* SessionStorage will automatically deleted when user close tab, but does not delete when user refresh website.

Here is what happen if you use sessionStorage to save user token/profiles.

* If user open 2 tabs of the same website and user profile changes, it does not changes on other tab. 
* If user logout first tabs, second tab is still logged in.
* user have to login again when close tab and open a new one.

## LocalStorage VS Cookie

You should not save user profile and authentication token into cookies because it can be hacked by 'CSRF' method. More info on this [link](https://hydrasky.com/network-security/cross-site-request-forgery-csrf/)

# Prevent Authentication Hacking

* use https all the time.
* You should use LocalStorage to save user profile/authentication token (not cookie. see topic above)
* when user refresh website. Frontend should refresh user profile (see topic "Refresh Token" above).
* You should not send password or sensitive information in GET method. Even though GET param is encrypted in https but it may logged in nginx or django.

