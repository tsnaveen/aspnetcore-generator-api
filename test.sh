#!/bin/bash

COMPONENT=aspnetcore-generator-api
VERSION=1.0
IMAGE="tsnaveen/${COMPONENT}:${VERSION}-test"

# Any subsequent(*) commands which fail will cause the shell script to exit immediately
set -e
set -o pipefail

# Workaround to remove dangling images
docker-compose -f ./docker-compose.test.yml down

export IMAGE
docker-compose -f ./docker-compose.test.yml up --build --abort-on-container-exit --exit-code-from test

# Workaround to remove dangling images
docker-compose -f ./docker-compose.test.yml down