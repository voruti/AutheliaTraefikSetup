#!/bin/bash
cd "$(dirname "$0")"

docker compose -f ./host1/authelia/docker-compose.yml down
docker compose -f ./host1/traefik/docker-compose.yml down
docker compose -f ./host1/service/docker-compose.yml down
