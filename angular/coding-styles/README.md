# Angular Style Guide (Optional)

<br>
<br>

**this page is in draft mode. it is optional to follow guidelines on this page.**

<br>
<br>

## Style Guide

### Base Style Guide

The main code in Angular included with Typescript, HTML, SCSS.

We follow [Google style guide for HTML/CSS](https://google.github.io/styleguide/htmlcssguide.html), [Typescript](https://google.github.io/styleguide/tsguide.html) and [SCSS](https://sass-guidelin.es/). The rest of the document describes additions and clarifications.



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

