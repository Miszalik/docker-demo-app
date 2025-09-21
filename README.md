# Docker Demo App

A simple web application built with **Python** and **Flask**, prepared to run both locally and inside a **Docker** container.  
This project is intended as a demo showing how to containerize a basic Flask app.

---

## Installation

To install the application, you can use the setup script:

``` bash
sudo ./setup.sh
```

To update the application:

``` bash
sudo ./update.sh
```

## Run locally

To run the application locally (without Docker):

``` bash
poetry install
poetry run flask --app app.app run --host=0.0.0.0, --port=8080
```

## Technologies

- Python 3
- Flask
- Poetry
- Docker
- Redis
- Portainer