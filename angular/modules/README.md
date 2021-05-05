# Module

Grouping components into a module. Learn more [https://angular.io/guide/architecture-modules](https://angular.io/guide/architecture-modules)

# When to use module?

- Each menu view should has its own module.
- When you have a component that depend on multiple components.
- Component, Pipe that will be used in multiple modules.

# Why module?

- Angular is not allow you to declare a component in multiple modules, but you can import a module into multiple modules.
- Module is very reusable, and it's easier to integrate. You would only need to import a module and reuse multiple components that exported.

# How to create module?

With Angular CLI

```shell script
# Descriptive
$ ng generate module my-module

# Short
$ ng g m my-module
```

Read more [https://angular.io/cli/generate#module](https://angular.io/cli/generate#module).
