set COMPONENT="aspnetcore-generator-api"
set VERSION=1.0
set BUILD_NUMBER=1
rem IMAGE1="tsnaveen/${COMPONENT}:${VERSION}-${BUILD_NUMBER-0}"
set IMAGE2=="tsnaveen/${COMPONENT}:latest"
set TAG="v${VERSION}-${BUILD_NUMBER-0}"

rem cd /cygdrive/c/Repositories/learning/docker/aspnotecore-generator-api

rem # Any subsequent(*) commands which fail will cause the shell scrupt to exit immediately
set -e
set -o pipefail

rem Set tag on git repo
git tag $TAG
git push --tags

export $DOCKER_USER=tsnaveen
export $DOCKER_PASS=Shanmukh10

rem # Push production image to docker registry
docker login -u $DOCKER_USER -p $DOCKER_PASS
docker push $IMAGE1
docker push $IMAGE2

