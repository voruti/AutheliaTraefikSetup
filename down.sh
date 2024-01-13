#!/bin/bash
cd "$(dirname "$0")"

docker compose -f ./host1/docker-compose.yml down
docker compose -f ./host2/docker-compose.yml down
