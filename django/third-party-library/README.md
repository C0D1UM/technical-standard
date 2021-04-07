# Third-Party Library Guideline

Best practices for which library to use and how to choose.

## How to choose a library?

Here are some checklist when choosing a new library:

- Check the amount of star in GitHub, the more star the better.
- Check if documentation is available.
- Check how often library getting updates.
- Check when is the latest code update, if the latest update was years ago meaning
the library probably not being maintained anymore.
- Check if there are unit tests, usually good code come with unit test.
- You can get more analytics from the **Insights** tab in GitHub, to see if
the community with this library is good enough.
- Check security report in **Security** tab.

## Recommended Libraries

These are the recommended library for each categories. This does not mean that
every project must install all the libraries listed here. **Only install what
you need to use**. Best practices is install when you need instead of install
from all at once, keep your requirements growing.

### Common

- [Django](https://www.djangoproject.com): web framework.
- [Rest Framework](https://www.django-rest-framework.org): API Endpoint.
- [Simple JWT](https://django-rest-framework-simplejwt.readthedocs.io/en/latest/): authentication with JSON Web Token.
- [CORS Header](https://github.com/adamchainz/django-cors-headers): browser CORS header.
- [Filter](https://django-filter.readthedocs.io/en/stable/): filter data from URL parameters.
- [Model Controller](https://github.com/NorakGithub/django-model-controller): keeping track of database record.

### Excel

- [OpenPyXL](https://openpyxl.readthedocs.io/en/stable/): working with Excel
- [Excel Tool](https://pypi.org/project/django-excel-tools/): validate data from excel

### PDF

- [WeasyPrint](https://weasyprint.readthedocs.io): generate PDF from HTML

### Development

- [Debug Toolbar](https://django-debug-toolbar.readthedocs.io/en/latest/): optimizing API performance.
- [Environ](https://django-environ.readthedocs.io/en/latest/): helper when using environment variable.
- [ipdb](https://github.com/gotcha/ipdb): extended from pdb for code completion and more.

### Unit Test

- [Test Without Migrations](https://pypi.org/project/django-test-without-migrations/): speed up testing without running database migration and playing around with model design.
- [Factory Boy](https://factoryboy.readthedocs.io/en/stable/orms.html): mocking model data.
- [Slow Test](https://github.com/realpython/django-slow-tests): reporting which unit test run too slow.
- [Coverage](https://docs.djangoproject.com/en/3.1/topics/testing/advanced/#integration-with-coverage-py): reporting amount of code that covered by unit test.
- [Freezegun](https://github.com/spulec/freezegun): freeze time for testing.

### Monitoring

- [Sentry-SDK](https://docs.sentry.io/platforms/python/guides/django/): unhandled exception report
