#!/bin/bash

COMPONENT=generator
VERSION=1.0
BUILD_IMAGE="aspnetcore/${COMPONENT}:${VERSION}-build"
TEST_IMAGE="aspnetcore/${COMPONENT}:${VERSION}-test"

rm -rf ./obj
rm -rf ./run/bin
rm -rf ./run/obj
rm -rf ./src/bin
rm -rf ./src/obj
rm -rf ./test/bin
rm -rf ./test/obj
rm -rf *.nupkg

docker rmi $BUILD_IMAGE --force
docker rmi $TEST_IMAGE --force
docker image prune --force