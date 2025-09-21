#!/bin/bash
set -e

docker compose down -v

git pull
cp .env.example .env

docker compose build --no-cache
docker compose up -d