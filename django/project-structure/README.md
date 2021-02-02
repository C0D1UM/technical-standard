# Project Structure

## Introduction

The difference in structure of each project makes it developers difficult to understand the code. This standard comes to solve this problem and to reduce the time used when developers study the project.

## Structure

> **Note:**
> - `__init__.py` is omitted
> - Every file/directory name should be [snake_case](https://en.wikipedia.org/wiki/Snake_case)

<pre>
    •
    ├── [project_name]/
    │   ├── apps/
    │   │   ├── [app1_name]/ <sup><a href="#application-name">?</a></sup>
    │   │   │   └── ..
    │   │   ├── [app2_name]/
    │   │   │   └── ..
    │   │   └── ..
    │   ├── api_urls.py <sup><a href="#api-urls">?</a></sup>
    │   ├── asgi.py
    │   ├── celery.py
    │   ├── settings.py
    │   ├── urls.py
    │   └── wsgi.py
    ├── locales/
    │   └── [lang]/
    │       └── LC_MESSAGES/
    │           └── django.po
    ├── static/
    │   ├── css/
    │   ├── images/
    │   └── ..
    ├── .flake8
    ├── .coveragerc
    ├── .gitignore
    ├── Dockerfile
    ├── manage.py
    ├── requirements.in
    └── requirements.txt
</pre>

## Explanation

### Application Name

Every applciation name should be **noun**, is in the **plural** form, and using underscore (`_`) to improve readability <sup>[1]</sup>.

```python
memos            # Yes
monthly_reports  # Yes

person           # No, because it is in singular form
externalservices # No, because it didn't use underscore
```

#### Notes

<sup>[1]</sup> There is no best practice choosing between singular or plural form but it should match [PEP8's Package and Module Names](https://www.python.org/dev/peps/pep-0008/#package-and-module-names).

### API URLs

It should contains only [Django REST Framework's router and urlpatterns](https://www.django-rest-framework.org/api-guide/routers/).
