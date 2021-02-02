# Project Structure

## Introduction

The difference in structure of each project makes it developers difficult to understand the code. This standard comes to solve this problem and to reduce the time used when developers study the project.

## Structure

> **Note:** `__init__.py` is omitted in this tree.

<pre>
•
├── [app_name](http://test.com)/
│   └── apps/
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
