# Datetime

## Python

There are two different kind of datetime in Python

1. Naive Datetime - datetime without timezone
1. Aware Datetime - datetime with timezone

## Django Configuration

Always enable timezone support in Django `settings.py`

```py
# django
USE_TZ = True
TIME_ZONE = "Asia/Bangkok"

# celery
CELERY_TIMEZONE = "Asia/Bangkok"
```

## Datetime Comparison

When you are getting data from the database you will get the Aware Datetime.
If you need to compare it with a Datetime object, it should be Aware Datetime object see [below](#get-current-datetime).

## Get current datetime

Use `timezone.now()` or `timezone.localtime` over `datetime.now()`

```py
import datetime

from django.utils import timezone

# Yes
now = timezone.now() # get current Aware datetime in UTC

now = timezone.localtime() # get current Aware datetime in Asia/Bangkok


# No
now = datetime.datetime.now() # get current Naive datetime
```

## Convert Naive Datetime to Aware Datetime

```py
import datetime

import pytz
# Yes
now = datetime.datetime.now() # current Naive datetime

tz = pytz.timezone("Asia/Bangkok")
aware_now = tz.localize(now)

# No
now = datetime.datetime.now() # current Naive datetime

tz = pytz.timezone("Asia/Bangkok")
aware_now = now.replace(tzinfo=tz) # return wrong datetime

```

## Convert Aware Datetime to different timezone

```py
from django.utils import timezone

import pytz

now = timezone.now() # current datetime in UTC

tz =  pytz.timezone("Asia/Bangkok")

bkk_now = now.astimezone(tz) # get current datetime in Asia/Bangkok
```
