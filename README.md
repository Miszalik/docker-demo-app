# Docker Demo App

## TODO
- [x] Install docker on VM
- [x] Create simple app (Python Flask + Redis)
- [x] Dockerizing
- [x] Docker compose
- [x] Network and volumes

## Run app locally

``` bash
poetry install
poetry run flask --app app.app run --host=0.0.0.0, --port=8080
```

## Run using docker

``` bash
docker compose up
```

