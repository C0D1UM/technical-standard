# Deployment Guideline

This guideline will recommend you about best practice on deployment in various environments.

## Django Deployment Checklist

First thing that you have to do is checking official [Deployment checklist](https://docs.djangoproject.com/en/3.2/howto/deployment/checklist/) from _Django_.

## Port Mapping

- **Do not** map out Django port (8000, in most case) to host since there is no need to connect directly to Django (nginx is connected to Django within local Docker network)
- It is **not recommended** to map out Redis port if you're not planning to debug its database
- If your server contains multiple project instances, you also need to specify the outside ports of nginx to your project's dedicated IP.

## Firewall

| test |
| ---- |
| :white_check_mark: |
