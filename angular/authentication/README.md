# Authentication Guidelines

## Login
```ts
// before call login API, you should clear all authentications in local storage
localStorage.clear();

// then, call login API request
this.tokenService
    .login({
        // username should convert to lowercase and trim spaces.
        username: this.username.toLocaleLowerCase().trim(),
        password: this.password,
    })
    .subscribe(
        (user: any) => {
            // save token and user information to local storage.
            localStorage.setItem('currentUser', data)
            // you may save more user information as you want ....
        },
        (error) => {
            // display error message to user as you want ...
        }
    );
```

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

### (Optional) Refresh Token Before Call API
If token time is very short. (For example, you have to implement for bank website which token is expire in 5 minutes), You must check token expiration time everytime before call request. 

```ts
function refreshTokenIfExpired () {
    // decode jwt token.
    let base64Url = localStorage.currentUser.split('.')[1];
    let base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    let jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));

    let decoded = JSON.parse(jsonPayload);
    const now = Date.now().valueOf() / 1000

    let refreshToken = false
    // check if token will be expired in 5 minutes (300000 = 5 minutes)
    if (typeof decoded.exp !== 'undefined' && decoded.exp < now - 300000) {
        refreshToken = true
    }
    if (typeof decoded.nbf !== 'undefined' && decoded.nbf > now - 300000) {
        refreshToken = true
    }

    // call refresh token if it is nearly expired.
    if (refreshToken) {
        this.authService.refreshToken( ... )
    }
};
```
