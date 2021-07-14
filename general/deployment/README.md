# Deployment Guideline

This guideline will recommend you about best practice on deployment.

## Secret & Credentials

### Strong Password

Strong password makes the application more difficult to be hacked.
**Do not** use any common passwords which can be guessed.
Read more in [What is strong password?](https://searchenterprisedesktop.techtarget.com/definition/strong-password).

### Credentials

**Do not** store any passwords or credentials in source code (except passwords for local use and testing).
Storing in GitLab CI variable or in a server is recommended.

### Storing Password In Database

`SHA-128` or more is required for password hashing in database. Django will handles this automatically by default.

### Sensitive Information

In order to prevent data leaking, every sensitive information (for example, first name, last name, birth date, credit card number, and etc) is recommended to be encrypted using `AES-256` or more. Encryption key is also required to store safely.

## Network & Security

### Server Hardening

It is **recommended** to complete a Server Hardening process in a server.

### Port Expose

- **Do not** expose Django port (8000, in most case) to host since there is no need to connect directly to Django (nginx is connected to Django within local Docker network)
- It is **not recommended** to expose Redis port if you're not planning to debug its database
- If your server contains multiple project instances, you also need to specify the outside ports of nginx to your project's dedicated IP.

### Firewall

> :white_check_mark:  = Allow

| Application (Default Port) / Source | Public | Internal <sup>[1]</sup> | CI Server <sup>[2]</sup> |
| ------------- | ------ | ----------------------- | ------------------------ |
| HTTP (80) | :white_check_mark: | :white_check_mark: | |
| HTTPS (443) | :white_check_mark: | :white_check_mark: | |
| SSH/SFTP (22, 22222) | | :white_check_mark: | :white_check_mark: |
| Postgres (5432) | | :white_check_mark: | |
| Redis (6379) | | :heavy_check_mark: <sup>[3]</sup> | |

<small>

<sup>[1]</sup> For example, HQ and office IPs.  
<sup>[2]</sup> For example, _GitLab Runner_ and _Buddy_.  
<sup>[3]</sup> In case you're planning to debug Redis database. Recommendation is _deny_.  

</small>

### HTTPS

- **Always** use _HTTPS_ instead of _HTTP_
- _Let's Encrypt_ certificate renewal automation has to be set up on a server
- Turn off _TLS 1.0_, _TLS 1.1_ supports in nginx (`ssl_protocols`). (It is recommended to use _TLS 1.2_+)
- Use _EECDH_ or _EDH_ for HTTPS encryption in nginx (`ssl_ciphers`)
- **Do not** allow nginx access from plain server IP by specify `server_name` to your domain name instead of widely open (`_`)

### Docker Restart Policy

It is **recommended** to set restart policy to `always` to make Docker containers automatically restart when something fail, or when VM restarts. Read more in [Start containers automatically](https://docs.docker.com/config/containers/start-containers-automatically/).

## Django

### Deployment Checklist

You can also check an official [deployment checklist](https://docs.djangoproject.com/en/3.2/howto/deployment/checklist/) from _Django_.

### Gunicorn Max Requests

**Always** set max requests for _Gunicorn_.

```bash
gunicorn --max-requests=1000
```

### Gunicorn Worker

It is recommended to set Gunicorn worker number to `(N x 2) + 1` (where `N` is number of CPU core). Note that if your server contains more than one application instance, you may need to split the available worker number from the formula to each instance.

## References

- CODIUM Production Readiness
