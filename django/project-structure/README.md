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
    │   │   ├── common/ <sup><a href="#sup19sup-codecommoncode-application">19</a></sup>
    │   │   │   └── ..
    │   │   ├── [app1_name]/ <sup><a href="#sup1sup-application-name">1</a></sup>
    │   │   │   ├── management/
    │   │   │   │   └── commands/
    │   │   │   ├── migrations/
    │   │   │   ├── templates/
    │   │   │   │   ├── css/ <sup><a href="#sup11sup-static-for-applications-template">11</a></sup>
    │   │   │   │   ├── fonts/ <sup><a href="#sup11sup-static-for-applications-template">11</a></sup>
    │   │   │   │   ├── images/ <sup><a href="#sup11sup-static-for-applications-template">11</a></sup>
    │   │   │   │   └── [template_name].html
    │   │   │   ├── tests/
    │   │   │   │   ├── test_[topic_name].py
    │   │   │   │   └── ..
    │   │   │   ├── admin.py
    │   │   │   ├── apps.py
    │   │   │   ├── choices.py <sup><a href="#sup12sup-codechoicespycode">12</a></sup>
    │   │   │   ├── exceptions.py
    │   │   │   ├── factories.py <sup><a href="#sup13sup-codefactoriespycode">13</a></sup>
    │   │   │   ├── filters.py <sup><a href="#sup14sup-codefilterspycode">14</a></sup>
    │   │   │   ├── functions.py <sup><a href="#sup15sup-codefunctionspycode">15</a></sup>
    │   │   │   ├── managers.py
    │   │   │   ├── models.py
    │   │   │   ├── paginations.py
    │   │   │   ├── permissions.py
    │   │   │   ├── serializers.py
    │   │   │   ├── services.py <sup><a href="#20-third-party-services">20</a></sup>
    │   │   │   ├── signals.py
    │   │   │   ├── tasks.py <sup><a href="#sup16sup-codetaskspycode">16</a></sup>
    │   │   │   ├── utils.py <sup><a href="#sup17sup-codeutilspycode">17</a></sup>
    │   │   │   └── views.py
    │   │   │   └── ..
    │   │   ├── [app2_name]/
    │   │   │   └── ..
    │   │   └── ..
    │   ├── api_urls.py <sup><a href="#sup2sup-codeapi_urlspycode">2</a></sup>
    │   ├── asgi.py <sup><a href="#sup7sup-codeasgipycode">7</a></sup>
    │   ├── celery.py <sup><a href="#sup8sup-codecelerypycode">8</a></sup>
    │   ├── settings.py
    │   ├── urls.py <sup><a href="#sup3sup-codeurlspycode">3</a></sup>
    │   └── wsgi.py <sup><a href="#sup9sup-codewsgipycode">9</a></sup>
    ├── locales/
    │   ├── [lang]/
    │   │   └── LC_MESSAGES/
    │   │       └── django.po
    │   └── ..
    ├── static/ <sup><a href="#sup10sup-static-across-applications">10</a></sup>
    │   ├── css/
    │   ├── fonts/
    │   ├── images/
    │   └── ..
    ├── .flake8 <sup><a href="#sup4sup-codeflake8code">4</a></sup>
    ├── .coveragerc <sup><a href="#sup5sup-codecoveragerccode">5</a></sup>
    ├── .gitignore <sup><a href="#sup6sup-codegitignorecode">6</a></sup>
    ├── Dockerfile
    ├── manage.py
    ├── requirements.in <sup><a href="#sup18sup-requirements">18</a></sup>
    └── requirements.txt <sup><a href="#sup18sup-requirements">18</a></sup>
</pre>

### Explanation

#### <sup>[1]</sup> Application Name

Every applciation name should be **noun**, is in the **plural** form, and using underscore (`_`) to improve readability <sup>[*]</sup>. `common` is an exception.

```python
memos            # Yes
monthly_reports  # Yes

person           # No, because it is in singular form
externalservices # No, because it didn't use underscore
```

<sup>[*]</sup> There is no best practice choosing between singular or plural form but it should match [PEP8's Package and Module Names](https://www.python.org/dev/peps/pep-0008/#package-and-module-names).

#### <sup>[2]</sup> `api_urls.py`

It should contains only [Django REST Framework's router and urlpatterns](https://www.django-rest-framework.org/api-guide/routers/).

#### <sup>[3]</sup> `urls.py`

It should contains only top-level `urlpatterns`. That is `urlpatterns` from any other packages including [`api_urls.py`](#sup2sup-codeapi_urlspycode)

#### <sup>[4]</sup> `.flake8`

See: [Flake8](https://flake8.pycqa.org/en/latest/)

#### <sup>[5]</sup> `.coveragerc`

See: [Coverage.py](https://coverage.readthedocs.io/)

#### <sup>[6]</sup> `.gitignore`

It should contains only `gitignore` for Django/Python application only.

See: [What is .gitignore?](https://www.freecodecamp.org/news/gitignore-what-is-it-and-how-to-add-to-repo/)

#### <sup>[7]</sup> `asgi.py`

It is not required if your application is not using [ASGI](https://docs.djangoproject.com/en/3.1/howto/deployment/asgi/).

#### <sup>[8]</sup> `celery.py`

It is not required if your application is not using [Celery](https://docs.celeryproject.org/en/stable/index.html).

#### <sup>[9]</sup> `wsgi.py`

It is not required if your application is not using [WSGI](https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/).

#### <sup>[10]</sup> Static Across Applications

Static files here should be used across many applications in the project.

#### <sup>[11]</sup> Static for Application's Template

Static files here should be used only in the certain application's template.

#### <sup>[12]</sup> `choices.py`

Contains [Django's Enumeration types](https://docs.djangoproject.com/en/3.1/ref/models/fields/#enumeration-types) class definitions

#### <sup>[13]</sup> `factories.py`

Contains [Factory Boy](https://factoryboy.readthedocs.io/) factories

#### <sup>[14]</sup> `filters.py`

Contains [django-filter](https://django-filter.readthedocs.io/) classes

#### <sup>[15]</sup> `functions.py`

Contains functions which are related with the business logic. Most of functions should be in this file. For example:

- Function to calculate SLA from work hour
- Function to removing expired products
- etc

#### <sup>[16]</sup> `tasks.py`

Contains [Celery](https://docs.celeryproject.org/en/stable/index.html) tasks

#### <sup>[17]</sup> `utils.py`

Contains **utility** functions which are not related with the business logic. For example:

- Date formatting
- Manipulating string
- etc

#### <sup>[18]</sup> Requirements

Using [`pip-tools`](https://github.com/jazzband/pip-tools) you can compile `requirements.in` into `requirements.txt` automatically.

#### <sup>[19]</sup> `common` Application

The `common` application is the application that you can put any code which is reused in many applications. You can put filters, permission classes, managers, and etc here. This is because of the [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) principle.

> Note: Inside `common` application, it should follow the standard of application as well.

#### <sup>[20]</sup> Third-Party Services

If your application connects to third-party services, this is where you want to put the service-related logics.
