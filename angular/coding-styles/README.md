# Angular Style Guide (Optional)

<br>
<br>

**this page is in draft mode. it is optional to follow guidelines on this page.**

<br>
<br>

## Style Guide

### Base Style Guide

The main programing language in Angular framework included with Typescript, HTML, SCSS. We follow

- [Google style guide for HTML/CSS](https://google.github.io/styleguide/htmlcssguide.html), [Typescript](https://google.github.io/styleguide/tsguide.html)
- [Kitty Giraudel style guide for SCSS](https://sass-guidelin.es/)
- [Angular Official for Angular](https://angular.io/guide/styleguide).

The rest of the document describes additions and clarifications below.

### Typescript

#### Indentation

The indentation in typescript we use 2 spaces for every new line. we don't tabs or mix tabs.

#### Return Type

We recommend to assign ***return type*** of method for precision and simple to read the surface of them. Some lint configuration as eslint will have warning with highlight.

```typescript
/** without return type */
isAdmin(role: string) {
  return role === 'admin';
}

/** recommend */
isAdmin(role: string): boolean {
  return role === 'admin';
}
```

#### Trailing Commas

If the an array or object literal has written in many line. The last field should be ended with comma.

```typescript
/** Yes */
const obj = {
  a: 'value1',
  b: 'value1',
  c: 'value1',
}

/** No */
const obj = {
  a: 'value1',
  b: 'value1',
  c: 'value1'
}
```

### HTML

#### Indentation

The indentation in HTML, we use 2 spaces for inside element. we don't tabs or mix tabs.

```html
<div id="div-1">
  <div id="div-2">
    <div id="div-3">
    </div>
  </div>
</div>
```

#### Line-Wrapping (Optional)

For wrapping the attribute of element, In base styles there is no recommendation. You may consider by readability. However, we suggest to wrap them with 4 spaces for the attribute indentation.

```html
<!-- not recommend - wrapping somewhere long line -->
<app-example *ngIf="isOpen" class="text-red" id="example-1" [dropdown]="dropdown" 
  (click)="onClick()" [(data)]="model">
  <button class="btn btn-primary">Hello World!</button>
</app-example>

<!-- Recommend -->
<app-example *ngIf="isOpen"
    class="text-red"
    id="example-1"
    [dropdown]="dropdown"
    (click)="onClick()"
    [(data)]="model">
  <button class="btn btn-primary">Hello World!</button>
</app-example>
```

## Linter

You should use [`eslint`](https://eslint.org/) instead of [`tslint`](https://palantir.github.io/tslint/) that is deprecated. The `eslint` is available to plug-ins that we suggest to use [`Angular ESLint`](https://github.com/angular-eslint/angular-eslint#migrating-an-angular-cli-project-from-codelyzer-and-tslint).

After you install `eslint` with Angular plug-in. you have to configure following the style guild.

## Formatter

### For Visual Studio Code (vscode)

For the configuration in vscode, go to Setting -> Extensions and choose the extension file that will configure.

> NOTE: We can press short key to enter setting UI by `CMD` + `,` as default.

- #### HTML

    These is the configuration that consistent with style guild.

    | Title | Value |
    |--------|----------------|
    | `Format: Wrap Attributes` |  `force`  |
    | `Format: Wrap Attributes Indent Size` | `2` |

- #### Typescript

    For typescript, we just set `TypeScript > Preferences: Quote Style` to `single`.

    We suggest to use `Prettier` extension to enhance formatting.

    If you use `Prettier`. There is the configuration following that.

    - `Prettier: Arrow Parent` = `always`
    - `HTML Whitespace Sensitivity` = `strict`

### For Pycharm

