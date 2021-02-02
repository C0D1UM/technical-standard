# Project Structure

## Introduction

The difference in structure of each project makes it developers difficult to understand the code. This standard comes to solve this problem and to reduce the time used when developers study the project.

## Structure

> **IMPORTANT:** Every file/directory name should be [snake_case](https://en.wikipedia.org/wiki/Snake_case)

> **Note:** `__init__.py` is omitted

<pre>
    •
    ├── [project_name]/
    │   ├── apps/
    │   │   ├── [app1_name]/ <sup><a href="#1-application-name">1</a></sup>
    │   │   │   └── ..
    │   │   ├── [app2_name]/
    │   │   │   └── ..
    │   │   └── ..
    │   ├── api_urls.py <sup><a href="#2-api-urls">2</a></sup>
    │   ├── asgi.py
    │   ├── celery.py
    │   ├── settings.py
    │   ├── urls.py <sup><a href="#3-urls">3</a></sup>
    │   └── wsgi.py
    ├── locales/
    │   └── [lang]/
    │       └── LC_MESSAGES/
    │           └── django.po
    ├── static/
    │   ├── css/
    │   ├── images/
    │   └── ..
    ├── .flake8 <sup><a href="#4-flake8">4</a></sup>
    ├── .coveragerc <sup><a href="#5-coveragepy">5</a></sup>
    ├── .gitignore <sup><a href="#6-gitignore">6</a></sup>
    ├── Dockerfile
    ├── manage.py
    ├── requirements.in
    └── requirements.txt
</pre>

## Explanation

### <sup>[1]</sup> Application Name

Every applciation name should be **noun**, is in the **plural** form, and using underscore (`_`) to improve readability <sup>[*]</sup>.

```python
memos            # Yes
monthly_reports  # Yes

person           # No, because it is in singular form
externalservices # No, because it didn't use underscore
```

<sup>[*]</sup> There is no best practice choosing between singular or plural form but it should match [PEP8's Package and Module Names](https://www.python.org/dev/peps/pep-0008/#package-and-module-names).

### <sup>[2]</sup> API URLs

It should contains only [Django REST Framework's router and urlpatterns](https://www.django-rest-framework.org/api-guide/routers/).

### <sup>[3]</sup> URLs

It should contains only [Django's urlpatterns](https://docs.djangoproject.com/en/3.1/topics/http/urls/).

### <sup>[4]</sup> Flake8

[Documentation](https://flake8.pycqa.org/en/latest/)

### <sup>[5]</sup> Coverage.py

[Documentation](https://coverage.readthedocs.io/)

### <sup>[6]</sup> .gitignore

[What is .gitignore?](https://www.freecodecamp.org/news/gitignore-what-is-it-and-how-to-add-to-repo/)
