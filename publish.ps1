$COMPONENT = "aspnetcore-generator-api"
$VERSION = 1.0
$BUILD_NUMBER = 1
$IMAGE1 = "tsnaveen/${COMPONENT}:${VERSION}-${BUILD_NUMBER}-0"
$IMAGE2 = "tsnaveen/${COMPONENT}:latest"
$TAG="v$VERSION-$BUILD_NUMBER-0"

$IMAGE1
$IMAGE2
$TAG

# Any subsequent(*) commands which fail will cause the shell scrupt to exit immediately
#set -e
#set -o pipefail

#Set tag on git repo
git tag $TAG
git push --tags

$DOCKER_USER = "tsnaveen"
$DOCKER_PASS = "Shanmukh10"

# Push production image to docker registry
docker login -u $DOCKER_USER -p $DOCKER_PASS
docker push $IMAGE1
docker push $IMAGE2

