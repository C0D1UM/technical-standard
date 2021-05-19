# MVC

## Model ViewController

### What is MVC?

MVC is a software development pattern made up of three main objects:
#### model
The Model is where your data resides. Things like persistence, model objects, parsers, managers, and networking code live there.
#### View
The View layer is the face of your app. Its classes are often reusable as they don’t contain any domain-specific logic. For example, a UILabel is a view that presents text on the screen, and it’s reusable and extensible.
#### Controller
The Controller mediates between the view and the model via the delegation pattern. In an ideal scenario, the controller entity won’t know the concrete view it’s dealing with. Instead, it will communicate with an abstraction via a protocol. A classic example is the way a UITableView communicates with its data source via the UITableViewDataSource protocol.

### Implementing the MVC
So First of all you have to know that if the MVC Design pattern implements correctly it can help you code and debug faster . In MVC model shouldn't know about the Views and also the Views shouldn't know about the model this means for example : View expects a model to show (that's it!) and also for the Model it doesn't matter that the View design or how it's gonna show and etc. here are some things that you should consider and follow to have a maintainable code: 
1- the controller should not manage every things :
If your controller does every things such as managing the UI and fetching the model and objects of the model , your controller will become `Massive View Controller!`.  Massive View Controllers usually are huge classes with hundreds lines of codes and it will be very hard to refactor them or even adding new features to them. If your app has to play a music you should have a player class which just expect a music to play and handling music settings such as speed , play , pause and other settings should be in that player class and your controller just calling that class to play that music . or for example if your app has to showing the data in a view , you shouldn't implement all of the View elements such as `UIButton`,`UITableView`and other UI elements in the view controller. every things that user can see in the one page doesn't mean that you have to implement them in the one view controller as well!. for this case first you have to consider the UI elements of your page , if they are not few elements you can divide the page by 2 or more parts and implementing each parts separately in Xib or another View Controller. so you have two ways using another view controller with container to connect to the main view controller or using a xib file to handle every UI elements and showing them. using these ways have a lot of advantages : 
#### First
you don't need to set constraints to all of the elements in your whole page and as you divided your UI elements of your page to some parts you have less constraints to set so for making your app responsive you have less problems.
#### Second 
you can reuse these parts in any other parts of your app , so you don't need to implement the similar parts again and again. you just need to create an object of the UI that you implemented and using that.
#### Third
your story boards will be much lighter and faster and as you implemented the UI elements in the XIb files you have less conflicts with your teammates when working on the same project .

2- you should not using one story board for your whole project . when you are using one story board for your whole project you will have these problems below :
*you will have conflicts with your teammates when you want to work on the story board because you have one story board and even if you work in another part of that this one still is one file.
*your story board will be very heavy to load and some times it's very hard to see the relation between the view controllers in the story board.




```swift
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

If token time is very short (Ex. Banking website which token is expired in 5 minutes), you must check token expiration time before calling request and refresh token if needed. See code below.

```ts
function refreshTokenIfExpired () {
    // decode jwt token. This is very technical, you can skip this part if you don't understand.
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

Authentication token interceptor will add token to request.

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
    // handle request that don't want to add authentication header.
    // Sample Code: `this.http.get('https://somewebsite/', {headers:{skip:"true"})`
    if (req.headers.get("skip")) {
       return next.handle(req);
    }

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

```ts
# Bad. Do not save files data into localstorage. Size limit is about 5 MB.
let bytes = .... 
localStorage.setItem('file', bytes)
```

## LocalStorage VS SessionStorage

You should not save user profile into SessionStorage. Different between LocalStorage and SessionStorage is below.

* LocalStorage will save data and share that data when user open second tabs.
* SessionStorage will not share data when across tabs.
* SessionStorage will automatically deleted when user close tab, but does not delete when user refresh website.

Here is what happen if you use SessionStorage to save user token/profiles.

* If user open second tabs of the same website and user profile changes, it will not change on the first tab.
* If user logout from the first tabs, second tab is still logged in.
* User have to login again when close tab and open a new one.

## LocalStorage VS Cookie

You should not save user profile and authentication token into cookies because it can be hacked by 'CSRF' method. More info on this [link](https://hydrasky.com/network-security/cross-site-request-forgery-csrf/)

# Prevent Authentication Hacking

* Use https all the time.
* You should use LocalStorage to save user profile/authentication token (not cookie. see topic above)
* When user refresh website, frontend should refresh user profile (see topic "Refresh Token" above).
* You should not send password or sensitive information in GET method. Even though GET param is encrypted in https but it may be logged in Nginx or Django.
