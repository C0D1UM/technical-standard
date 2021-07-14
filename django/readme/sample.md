
# Requirements

* Docker version >= 17.12.0-ce
* docker-compose version >= 1.18.0
* IntelliJ IDEA >= 2018.1

# Setup Project (First time only)

## For Mac

```sh
make reset-init-db
```

## For Ubuntu

 1. Open terminal and run command below, make sure you are in project root directory

    ```sh
    nvm install 9.10.1
    nvm install 8.10.0
    make -s ubuntu-setup-project
    ```

 1. Setup docker ip

    ```sh
    sudo bash manage-host.sh addhost host.docker.internal 127.0.0.1
    ```

# Run Project

```sh
make run-django
```

# Accounts

## API

* url: `http://localhost:8000/`
  * admin
    * username:admin
    * password:P@ssword
  * user
    * username:test_user
    * password:P@assword

## DB

* url: `localhost:5432`
* database: my_db
* username: postgres
* password: postgres

# Miscellaneous Tools

## Clean Project

```sh
make clean-project
```

command above will clean docker container/images, reset db and run django

## Reset DB

```sh
make reset-init-db
```

## Dump DB

```sh
make dump-local-db
```

You will see file `mydump` in current directory.

## Restore DB

 1. Copy `mydump` file to `<project root>/django` folder
 1. run command

    ```sh
    make restore-local-db
    ```
