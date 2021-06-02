# Module

Grouping components into a module. Learn more [https://angular.io/guide/architecture-modules](https://angular.io/guide/architecture-modules)

## When to use module?

- Each menu view should has its own module.
- When you have a component that depend on multiple components.
- Component, Pipe that will be used in multiple modules.

## Why module?

- Angular is not allow you to declare a component in multiple modules, but you can import a module into multiple modules.
- Module is very reusable, and easy to integrate. You would only need to import a module and reuse multiple components that exported.

## How to create module?

With Angular CLI

```shell script
# Descriptive
$ ng generate module my-module

# Short
$ ng g m my-module
```

Read more [https://angular.io/cli/generate#module](https://angular.io/cli/generate#module).

## Caution

- Do not put everything into one module, this will cause any module that import this module become really big, and sometime wasted since some components are not used.

### Do Not Do This

#### Structure

```text
shared
-- navbar/
-- button/
-- shared.module.ts
views
-- index/
---- index.module.ts
```

#### Implementation

```typescript
// shared-module.ts
...
declaration: [
    NavbarComponent,
    ButtonComponent
],
exports: [
    NavbarComponent,
    ButtonComponent,
]

// index.module.ts
imports: [
    SharedModule,
]
```

### Do This

#### Structure

```typescript
shared
-- navbar/
---- navbar.module.ts
-- button/
---- button.module.ts
views
-- index/
---- index.module.ts
```

#### Implementation

```typescript
// navbar.module.ts
...
declaration: [
    NavbarComponent,
],
exports: [
    NavbarComponent,
]
// button.module.ts
...
declaration: [
    ButtonComponent,
],
exports: [
    ButtonComponent,
]

// index.module.ts
imports: [
    NavbarModule,
    ButtonModule,
]
```

## Exception

If you are 100% sure that a group of components will be used in every where in
the project, you can create a shared module.
