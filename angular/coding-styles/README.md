# Angular Style Guide (Optional)

<br>
<br>

**this page is in draft mode. it is optional to follow guidelines on this page.**

<br>
<br>

## Style Guide

### Base Style Guide

The main programing language in Angular framework included TypeScript, HTML, SCSS. We follow

- [Google style guide for HTML/CSS](https://google.github.io/styleguide/htmlcssguide.html), [TypeScript](https://google.github.io/styleguide/tsguide.html)
- [Kitty Giraudel style guide for SCSS](https://sass-guidelin.es/)
- [Angular Official for Angular](https://angular.io/guide/styleguide).

The rest of the document describes additions and clarifications below.

### TypeScript

#### Indentation

For the indentation in TypeScript, we use **2 spaces** for every new line. Do not use tabs or spaces mixed with tabs.

#### Return Type

Let's make it mandatory for return type of method for precision and simple to read the surface of them. Some lint configuration as eslint will have warning with highlight.

```typescript
/** No */
isAdmin(role: string) {
  return role === 'admin';
}

/** Yes */
isAdmin(role: string): boolean {
  return role === 'admin';
}
```

#### Trailing Commas

If an array or object literal is written in many lines, the last object should be ended with comma.

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

For the indentation in HTML, we use **2 spaces** for elements. Do not use tabs or spaces mixed with tabs.

```html
<div id="div-1">
  <div id="div-2">
    <div id="div-3">
    </div>
  </div>
</div>
```

#### Line-Wrapping (Optional)

For wrapping the attribute of elements, we wrap them with 4 spaces for the attribute indentation.

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

You should use [`eslint`](https://eslint.org/) instead of [`tslint`](https://palantir.github.io/tslint/) is deprecated. `eslint` is available as a plug-in and we suggest you to use [`Angular ESLint`](https://github.com/angular-eslint/angular-eslint#migrating-an-angular-cli-project-from-codelyzer-and-tslint).

After you install `eslint` with Angular plug-in. You may have to valid some configuration following the style guide.

## Formatter

### For Visual Studio Code (vscode)

For the configuration in vscode, go to Setting -> Extensions and choose the extension file that will configure.

> NOTE: By default, we can press short key to enter setting UI by `CMD` + `,` (MacOS).

- #### HTML

  These is the configuration that consistent with style guide.

  | Title | Value |
  |--------|----------------|
  | `Format: Wrap Attributes` |  `force`  |
  | `Format: Wrap Attributes Indent Size` | `4` |

- #### TypeScript

  For TypeScript, we just set `TypeScript > Preferences: Quote Style` to `single`.

  We suggest to use `Prettier` extension to enhance formatting.

  If you use `Prettier`. There is the configuration following that.

  - `Prettier: Arrow Parent` = `always`
  - `HTML Whitespace Sensitivity` = `strict`

### For WebStorm

For WebStorm, go to Preference. In sidebar, choose Editor -> Code Style and select programing language to configure.

- #### HTML

  When entering to HTML configuration page. You can set the configuration following below.

  - In _Tabs and Indents_ tab, set `indent` = `4`.
  - In _Other_ tab, set `Wrap attributes` = `Wrap always`.

- #### TypeScript

  In _Punctuation_ tab, you will see three lines. Set them like below.

  - `Use` semicolon to terminate statements `always`
  - Use `single` quotes `always`
  - Trailing comma: `Add when multiline`

### EditorConfig

If the setting configuration in your editor has no effect. Please check the existence of `.editorconfig` file in your project where the configuration can be overridden.
