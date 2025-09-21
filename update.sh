#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

docker compose down -v

git pull
cp .env.example .env

docker compose build --no-cache
docker compose up -d