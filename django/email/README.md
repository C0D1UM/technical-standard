# Sending Email

Best practices when working on sending email feature.

## Use Django Build-in Email Backend

Read more [https://docs.djangoproject.com/en/3.1/topics/email/](https://docs.djangoproject.com/en/3.1/topics/email/).

## Email Body Best Practices

Some email client like GMail scan the email body before notify user so here some
best practices preventing email not received by customer immediately.

- Use plain-text email if possible
- When include url always display it to user, do not hide it. Client like GMail
will scan to see if the given url is redirect to page as it says.
- Allow user to unsubscribe the newsletter, by adding a url redirect to a form
that unsubscribe user from newsletter.

## Prevent Actually Send Email to Customer

There might be time that you would like to debug or fix email sending bug, and
you dump data from the production to reproduce. There are high chances that you
accidentally send email to actual customer since you are using production
database. Below are some best practices handling this problem:

### Domain Name Filtering

In Django settings file, you should have a setting that only allow email to send
to specific email address.

```python
# settings.py
ALLOW_EMAIL_DOMAINS = env.list('ALLOW_EMAIL_DOMAINS', default=['codium.co'])

# send_email.py
receivers = [
    'a@codium.co',
    'b@gmail.com',
    'c@sale.com',
]

allowed_receivers = []
# Do the filtering
# After filtered, allowed_receivers should has only ['a@codium.co']

from django.core.mail import send_mail
send_mail(
    'Subject',
    'Message',
    allowed_receivers,
    fail_silently=False
)
```

So before sending email, you can filter for only domain name in allowed list.

### Log Email to Console

The second solution is when running local environment you can use Django console
email backend. When define this in `settings.py` it will only log email to
console instead of actually connecting to SMTP server and send email.

```python
# settings.py
EMAIL_BACKEND = env(
    var='DJANGO_EMAIL_BACKEND',
    default='django.core.mail.backends.console.EmailBackend'
)
```

### MailHog

Using MailHog allowed you to actually send email via SMTP without delivering
to the client email server. It also provided a simple web interface, so we able
to check the sent email. Here the simplest setup using `docker-compose`:

```yml
version: '3'
services:
    mail:
        image: mailhog/mailhog
        port:
            - 1025:1025 # SMTP Server
            - 1080:1080 # Web UI
```

**Note:** MailHog purposes is only for testing small amount of emails, when
sent large amount of email to MailHog, it will show some performance issue like
mail is missing or slow loading.

## Using SendGrid

### REST API vs SMTP

From experiences, SendGrid email is more stable when using API, so I would
recommend using SendGrid API instead of SMTP.

### Dedicate IP Address

Use dedicate ip feature when ever possible (this is a pay feature). By using a
dedicated IP, allow us to not use the shared IP from SendGrid. Since the
shared IP address is free, people try to use it for bad purposes and this
cause those shared IP to be banned from some email server like HotMail, Gmail,
etc., so if you wonder why email is not received by the customer,
this could be the reason.
