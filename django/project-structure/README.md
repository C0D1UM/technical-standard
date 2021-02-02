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
    │   ├── api_urls.py <sup><a href="#2-api-urls-py">2</a></sup>
    │   ├── asgi.py <sup><a href="#7-asgi-py">7</a></sup>
    │   ├── celery.py <sup><a href="#8-celery-py">8</a></sup>
    │   ├── settings.py
    │   ├── urls.py <sup><a href="#3-urls-py">3</a></sup>
    │   └── wsgi.py <sup><a href="#9-wsgi-py">9</a></sup>
    ├── locales/
    │   └── [lang]/
    │       └── LC_MESSAGES/
    │           └── django.po
    ├── static/
    │   ├── css/
    │   ├── images/
    │   └── ..
    ├── .flake8 <sup><a href="#4-flake8">4</a></sup>
    ├── .coveragerc <sup><a href="#5-coveragerc">5</a></sup>
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

### <sup>[2]</sup> `api_urls.py`

It should contains only [Django REST Framework's router and urlpatterns](https://www.django-rest-framework.org/api-guide/routers/).

### <sup>[3]</sup> `urls.py`

It should contains only [Django's urlpatterns](https://docs.djangoproject.com/en/3.1/topics/http/urls/).

### <sup>[4]</sup> `.flake8`

See: [Flake8](https://flake8.pycqa.org/en/latest/)

### <sup>[5]</sup> `.coveragerc

See: [Coverage.py](https://coverage.readthedocs.io/)

### <sup>[6]</sup> `.gitignore`

It should contains only `gitignore` for Django/Python application only.

See: [What is .gitignore?](https://www.freecodecamp.org/news/gitignore-what-is-it-and-how-to-add-to-repo/)

### <sup>7</sup> `asgi.py`

It is not required if your application is not using [ASGI](https://docs.djangoproject.com/en/3.1/howto/deployment/asgi/).

### <sup>8</sup> `celery.py`

It is not required if your application is not using [Celery](https://docs.celeryproject.org/en/stable/index.html).

### <sup>9</sup> `wsgi.py`

It is not required if your application is not using [WSGI](https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/).
