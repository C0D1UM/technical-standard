# Contributing

## Participating in CODIUM Technical Standard Process

### Initial

- Fork this repository

### Document Format

- Choose the topic that you would like to add to (Django, Angular ...)
- Create a new directory inside that topic and make sure that directory name is kebab-case.
- The template would required a `README.md` file to explain about your topic standard.

### Adding New Category

1. Create a new directory in root directory, named it in kebab-case.
1. Create a file named `README.md` in newly created directory
1. Add category information into newly created `README.md` file. Here is an example for _Django_:
   ```
   ---
   title: Django
   has_sub_pages: true
   permalink: django
   ---
   ```
1. Put created file's path into section `header_pages` in `_config.yml` file
   ```
   header_pages:
     ...
     - django/README.md
   ```

### Process

- Request a review: Initiate a pull request to the [CODIUM Technical Standard](https://github.com/C0D1UM/technical-standard) when proposed a change or new feature, then assign the review from someone in tech council team (@earthpyy, @piyapan039285, @powerdefy and @NorakGithub), reviewer must be two or more to be able to merge. When everything looks good, the pull request will be merged.
