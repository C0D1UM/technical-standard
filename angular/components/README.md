# Components

This page will give you some practices and tips/tricks about Angular components.

## Clean Up Component to Prevent Memory Leak

For example, when you create `interval` observable

```ts
import { interval, Subscription } from 'rxjs';

@Component({...})
export class MyComponent implements OnInit, OnDestroy {
    ngOnInit () {
        // create interval observable
        const source = interval(60000);
        source.subscribe(...);
    }
}
```

You should use [subsink](https://github.com/wardbell/subsink) to remember your observable and call `unsubscribe` function when component destroyed.

```ts
@Component({...})
export class MyComponent implements OnInit, OnDestroy {
    private subs = new SubSink();

    ngOnInit () {
        const source = interval(60000);
        const source2 = interval(30000);
        const source3 = interval(10000);

        // remember subscription 
        this.subs.sink = source.subscribe(...);
        this.subs.sink = source2.subscribe(...);
        this.subs.sink = source3.subscribe(...);
    }

    // unsubscribed all subscriptions when component is destroyed.
    ngOnDestroy() {
        this.subs.unsubscribe();
    }
}
```

**Note** Angular will automatically clean up unsubscribe observable that created from `HttpClient`. More information [here](https://stackoverflow.com/questions/35042929/is-it-necessary-to-unsubscribe-from-observables-created-by-http-methods)

## Do not Set HTML to Element Directly

To prevent XSS Injections. Angular provides method to set HTML content.

```ts
// No
setValue(html: string) {
    this.element.nativeElement.innerHTML = html;
}

// Yes
setValue(html: string) {
    this.renderer.setElementProperty(
        el.nativeElement, 
        'innerHTML', 
        html
    );
}
```

```ts
// No
setTitle(title: string) {
    document.title = title;
}

// Yes
import { Title } from '@angular/platform-browser';
public constructor(private titleService: Title) { }

setTitle(title: string) {
    this.titleService.setTitle(title);
}
```

## Beware Variable Changes Inside Component

Sometimes when you get input variable from parent component and change values, the values will have effect to parent too.

```ts
class MyComponent {
    @Input() items: Int[];

    someFunctions() {
        // beware that changes will have effect on parent component.
        this.items[0] = 1;
    }
}
```

## Use 'trackBy' to Prevent Re-Rendering Same Data

`trackBy` is the keyword used with `ngFor` to tell angular to watch field in item. If that field changes, it will trigger Angular to re-render HTML.

```html
<div *ngFor="let item of list; trackBy:myFunction">
...
</div>
```

```ts
class myComponent {

    ngOnInit () {
        this.apiService.getSomeData().subscribe((response: any) => {
            this.list = response.data;
        });
    }

    myFunction(index, item){
        // If item.id changed, angular will re-render item.
        return item.id;
    }
}
```

## Use '?' to prevent exception in HTML

```html
// Yes
<div>
    {{ employee?.address?.city?.state }}
</div>

// Okay. if you want to hide element when data is null.
<div *ngIf="employee && employee.address && employee.address.city">
    {{ employee.address.city.state }}
</div>
```

## Use 'ng-container' with *ngIf to prevent nested HTML

`ng-container` does not create a real element in HTML. It can be used with `ngIf` or `ngFor`.

```html
// Yes
<ng-container *ngIf="...">
    <button> {{ 'LOGIN.SIGN-IN-ADFS' | translate }} </button>
</ng-container>

// Okay. if you really want to create div in HTML.
<div *ngIf="...">
    <button> {{ 'LOGIN.SIGN-IN-ADFS' | translate }} </button>
</div>

```
