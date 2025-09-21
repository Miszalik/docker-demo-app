#!/usr/bin/env bash
set -e

# Chceck is root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Check is commnand exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install docker
install_docker() {
    echo "Installing Docker..."
    apt-get update -y
    apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    if [ ! -e /etc/apt/keyrings/docker.gpg ]; then
        mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    fi

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
      $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

    apt-get update -y
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# Install docker compose
install_docker_compose() {
    echo "Installing Docker Compose..."
    DOCKER_COMPOSE_VERSION="v2.20.2"
    curl -SL "https://github.com/docker/compose/releases/download/v${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
}

# Creating default .env file
setup_env_file() {
    if [ -f ".env" ]; then
        echo "File .env already exists — skipping."
    elif [ -f ".env.example" ]; then
        echo "Creating .env file from .env.example..."
        cp .env.example .env
        echo ".env file has been created."
    else
        echo ".env or .env.example not found — skipping."
    fi
}

# Main script
if ! command_exists docker; then
    install_docker
else
    echo "Docker is already installed — skipping."
fi

if ! command_exists docker-compose; then
    install_docker_compose
else
    echo "Docker Compose is already installed — skipping."
fi

setup_env_file

echo "Setup completed."

# Run app using docker compose
echo "Starting the application using Docker Compose..."
docker compose up -d --build

echo "Application is running in the background."