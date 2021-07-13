# Deployment Guideline

This guideline will recommend you about best practice on deployment in various environments.

## Django Deployment Checklist

First thing that you have to do is checking official [Deployment checklist](https://docs.djangoproject.com/en/3.2/howto/deployment/checklist/) from _Django_.

## Port Mapping

- **Do not** map out Django port (8000, in most case) to host since there is no need to connect directly to Django (nginx is connected to Django within local Docker network)
- It is **not recommended** to map out Redis port if you're not planning to debug its database
- If your server contains multiple project instances, you also need to specify the outside ports of nginx to your project's dedicated IP.

## Firewall

> :heavy_check_mark: = Allow, :white_check_mark: = Allow with condition

| Application (Default Port) / Source | Public | Internal <sup>[1]</sup> | CI Server <sup>[2]</sup> |
| ------------- | ------ | ----------------------- | ------------------------ |
| HTTP (80) | :heavy_check_mark: | :heavy_check_mark: | |
| HTTPS (443) | :heavy_check_mark: | :heavy_check_mark: | |
| SSH/SFTP (22, 22222) | | :heavy_check_mark: | :heavy_check_mark: |
| Postgres (5432) | | :heavy_check_mark: | |
| Redis (6379) | | :white_check_mark:  <sup>[3]</sup> | |

<small>

<sup>[1]</sup> For example, HQ and office IPs.  
<sup>[2]</sup> For example, _GitLab Runner_ and _Buddy_.  
<sup>[3]</sup> In case you're planning to debug its database. Default is _deny_.  

</small>
