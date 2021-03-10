# Recommended Library

These are the libraries that is recommended to use when working with Excel.

- [OpenPyXL](https://openpyxl.readthedocs.io/en/stable/) this library allow us to
easily handling excel.
- [PyExcelerate](https://github.com/kz26/PyExcelerate) this library is used when
you need only speed meaning there is only data in the excel file, but if you need
personalization like color space it's not recommended.
- [Django Excel Tools](https://github.com/NorakGithub/django-excel-tools) this library
is used to validate data from excel.

# Import Data From Excel

Here are some best practices when working with importing data from excel.

## Data Validation

It is important to import correct data to our system, and we won't be able to
trust if user only fill the correct data. So before import data to the system,
each row and column must be validated the type. Doing this manually would take
too much time, so I would recommend using [Django Excel Tools](https://github.com/NorakGithub/django-excel-tools) for data validation.

## Simple

### When to use simple technique?

- The data importing will never be more than 2000 rows. (Tip validation and raise
400 when data is more than 2000 rows)

### How?

This would required a minimal setup, here the guides:

- User upload the excel.
- API received excel, and validate data inside excel.
- Import data to the system.
- When import data to the database try to import in chunks, says you have 2000
rows of data you split it into 500 rows each to import to the database.
- Return import status back to user.

Overall process should not take any longer than 30 seconds.

### Architecture

![Simple Architecture](img/simple-architecture.jpeg)

## Advance

- You don't know how many rows will be imported to the system at a time.

### How?

This would required more setup because we will need a background workers (Celery),
here are some guides:

- User upload the excel.
- API received excel, and validate data inside excel.
- After data validated, send file to background worker, then return status 203 as
the task has been accepted.
- When importing to database try to split into chunks, says you have 100,000 of
rows, you should split into 5,000 each time importing to the database.
- (Optional) Use more than one worker, so that you can import data in parallels.
- Use COPY instead of INSERT. There are limitation when using COPY, but COPY is
way more faster than INSERT. Read more about COPY [here](https://www.postgresql.org/docs/9.2/sql-copy.html).

### Architecture

#### Minimum

![Advance Architecture](img/advance-minimum-architecture.png)

#### Recommended

It's recommended to separate between worker and API server because usually workers
will use a lot of resources, so if workers down it wouldn't affect API Server.

![Advance Architecture](img/advance-recommended-architecture.png)
