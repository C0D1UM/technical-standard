# Directives

Angular directives is custom field in HTML. It will add custom logic to HTML elements. For example, changing CSS or HTML contents.

## Creating Directives Manually

Step below will guide you by example.

### Goal

You want to create custom field `appHighlight` which will add background color in the HTML element.

```html
<div appHighlight="#FFA500"> my message </div>
```

### Steps

1. Create file `highlight.directive.ts`

```ts
import { Directive, ElementRef, Input, SimpleChanges } from '@angular/core';

@Directive({
  selector: '[appHighlight]'
})
export class HighlightDirective {

  constructor(private el: ElementRef) { }

  @Input('appHighlight') highlightColor: string;

  ngOnChanges(changes: SimpleChanges){
    // set background color.
    if(changes.highlightColor){
        this.el.nativeElement.style.backgroundColor = this.highlightColor;
    }
  }
}
```

2. add `HighlightDirective` class into `app.module.ts` (or any module file you want).

```ts
@NgModule({
  declarations: [
    HighlightDirective,
    ...
  ],
```

## Field Usage Format

There are 2 formats on using Angular directives

1. Using with `[field]` format which will accept component variable.

```html
<div [appHighlight]="myColor"> my message </div>
```

Then, declare variable name in the component.

```ts
class myComponent {
  myColor: string = "#FFA500";
}
```

2. Using with `field` format (without bracket). This will accept fixed value only.

```html
<div appHighlight="#FFA500"> my message </div>
```

## Event Listener

You can setup Angular directives to listen element events. See sample code below.

```ts
import { HostListener } from '@angular/core';

@Directive({
  selector: '[appHighlight]'
})
export class HighlightDirective {
    ...

    @HostListener('click') onMouseClick() {
        // do something ...
    }

    @HostListener('mouseenter') onMouseEnter() { 
        // do something ...
    }

    @HostListener('mouseleave') onMouseLeave() {
        // do something ...
    }
}
```
