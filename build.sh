#!/bin/bash

COMPONENT=aspnetcore-generator-api
VERSION=1.0
IMAGE="tsnaveen/${COMPONENT}:${VERSION}-build"
CONTAINER="${COMPONENT}"

# Any subsequent(*) commands which fail will cause the shell script to exit immediately
set -e
set -o pipefail

# Remove build files
rm -rf ./obj

# Build docker image
docker build -f Dockerfile.build -t ${IMAGE} .

# Create and copy compiled files, then destroy
docker create --name ${CONTAINER} ${IMAGE}
docker cp ${CONTAINER}:/obj ./obj
docker rm ${CONTAINER}