# Security

Best practices for Angular Security.

## Official Best Practices

Here is the [url](https://angular.io/guide/security) to the official security
best practices.

Below are additional best practices provided from experiences.

## Storing Data

Try not store anything in browser, since it's on client side that mean client
can do anything on their machine. Remember that any data that's stored on
browser, you must find a way to protect it.

### What are the data you can store in browser?

- API Access Token
- Role Information
- Session ID

### What if I want to store a Session data?

This must be handle by backend. Backend can generate a unique session id, then
frontend can use this Session ID combine with API Access Token, to add or get
session data from backend.

### How do we protect Role information?

To prevent user pretend to be other role, backend API must check role info
every time calling API. If not authorized, backend can response HTTP 401 status
code. Then frontend can use response status for further step.

## HTTPS

Always serve using HTTPS, HTTPS help prevent middleman tampering data send and
receive between client and server.
