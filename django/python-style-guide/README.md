# Python Style Guide

## Base Style guide

We follow [Google style guide for Python](https://google.github.io/styleguide/pyguide.html). The rest of the document describes additions and clarifications.

## Linting

* You can use `pylint` with this [.pylintrc](https://raw.githubusercontent.com/C0D1UM/technical-standard/main/django/python-style-guide/.pylintrc) to check if your code passed the standard.

## Formatter

* You can use [yapf](https://github.com/google/yapf/) to avoid arguing over formatting.
* For PyCharm users, you can configure `yapf` as an external tool, see [How to config Pycharm](#pycharm-configuration).
* For VSCode users, in `setting.json` set `"python.formatting.provider": "yapf",`

### PyCharm Configuration

YAPF can be configured as an “External Tool” inside PyCharm and run on a per-file basis. Go to File -> Settings -> Tools -> External Tools and click +. In the dialog that opens enter the following details:

* Name: YAPF
* Description: Run Yapf formatter on current file
* Program: \<path to yapf>
* Arguments: `-i $FilePath$`
* Working directory: `$ProjectFileDir$`

\<path to yapf> is the full path to the YAPF executable on your system:

* Linux/Mac: `/usr/bin/yapf` if installed with a package manager or `$HOME/.local/bin/yapf` if installed with pip
* Windows: `<PythonPath>\Scripts\yapf.exe`

A YAPF item should now appear in the Tools -> External Tools menu. This can be bound to a shortcut key under File -> Settings -> Keymap -> External Tools.

## Imports

Imports should be grouped in the following order

* standard libraries
* third party libraries
* local modules

Each group should be sorted lexicographically, ignoring case, separate by an empty line, e.g.

```python
import collections
import queue
import sys

from absl import app
from absl import flags
import bs4
import cryptography
import tensorflow as tf

from book.genres import scifi
from myproject.backend import huxley
from myproject.backend.hgwells import time_machine
from myproject.backend.state_machine import main_loop
from otherproject.ai import body
from otherproject.ai import mind
from otherproject.ai import soul

```

Use import statements for packages and modules only, not for individual classes or functions. Note that there is an explicit exemption for imports from the typing module.

## None checks

Always use if foo is None: (or is not None) to check for a None

```python
# Yes
if foo is not None:
    pass

# No
if foo:
    pass
```

## Getting current time in Django

Always use `timezone.now()` rather than `datetime.now()`

```python
import datetime

from django.utils import timezone

# Yes
now = timezone.now()

# No
now = datetime.datetime.now()
```

## Checking if sequence is empty

For sequences, (strings, lists, tuples), use the fact that empty sequences are false

```python
# Yes
if seq:
if not seq:

# No
if len(seq):
if len(seq) == 0:
```

## Trailing commas

Trailing commas in sequences of items are recommended only when the closing container token ], ), or } does not appear on the same line as the final element. The presence of a trailing comma is also used as a hint to our Python code auto-formatter YAPF to direct it to auto-format the container of items to one item per line when the , after the final element is present.

```python
# Yes
golomb3 = [0, 1, 3]
golomb4 = [
    0,
    1,
    4,
    6,
]

# No
golomb4 = [
    0,
    1,
    4,
    6
]
```

## Joining Path

```python
import os

# Yes
data_path = os.path.join(data_folder, "data.csv")

# No
data_path = data_folder + "/data.csv"
```

## Logging

Prefer logging over print statement

```python
import logging

# Yes
logger = logging.getLogger(__name__)

if bad_mojo:
    logger.error('Something went wrong!')


# No
if bad_mojo:
    print('Something went wrong!')
```

## With statement

Always open file with context manager

```python
# Yes
with open('file.txt') as file:
    pass

# No
file = open('file.txt')
file.close()
```

For psycopg2 connection, you should use [try catch over `with` statement](https://www.psycopg.org/docs/usage.html#with-statement). `with` statement will help commit/rollback transaction, and `try catch` will help close connection.

```python
conn = psycopg2.connect(DSN)

try:
    # using with statement here, it will help commit/rollback transaction.
    with conn:
        with conn.cursor() as curs:
            curs.execute(...)

    # put another transaction here.
    with conn:
        with conn.cursor() as curs:
            curs.execute(...)
finally:
    # if you don't use connection anymore, close connection in finally block.
    conn.close()
```

## Testing

Always write unittest if you have enough time.
