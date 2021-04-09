
# Documentation

## Mock-up

<!-- markdownlint-disable-next-line MD034 -->
https://xd.adobe.com/view/something

## API Documentation

### Local Access

<!-- markdownlint-disable-next-line MD034 -->
http://localhost:8000/swagger

### Internal Access

<!-- markdownlint-disable-next-line MD034 -->
https://dev.project.heroapp.dev/swagger

(Use CODIUM network to access)

# Application URLs

## Local

<!-- markdownlint-disable-next-line MD034 -->
http://localhost:4200

## Development Server

<!-- markdownlint-disable-next-line MD034 -->
https://dev.project.heroapp.dev

## Staging Server

<!-- markdownlint-disable-next-line MD034 -->
https://staging.project.heroapp.dev

## Production Server

<!-- markdownlint-disable-next-line MD034 -->
https://project.heroapp.dev

# Requirements

* Docker version >= 17.12.0-ce
* docker-compose version >= 1.18.0
* IntelliJ IDEA >= 2018.1

# Setup Project (First time only)

```sh
make setup-nvm
```

# Run Project

```sh
make run-angular
```

# Accounts

* admin
  * username:admin
  * password:P@ssword
* user
  * username:test_user
  * password:P@assword

# Miscellaneous Tools

## Linting Project

```sh
make lint-angular
```

## Testing Project

```sh
make test-angular
```
