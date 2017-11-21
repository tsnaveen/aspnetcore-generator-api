$COMPONENT = "aspnetcore-generator-api"
$VERSION = "1.0"
$IMAGE = "tsnaveen/${COMPONENT}:${VERSION}-build"
$CONTAINER = "${COMPONENT}"

# Any subsequent(*) commands which fail will cause the shell script to exit immediately
#set -e
#set -o pipefail

$publishFolder = "./Publish/*"
# Remove build files
if(Test-Path ${publishFolder}) { Remove-Item ${publishFolder} -Force -Recurse; }

# Build docker image
docker build -f Dockerfile.build -t ${IMAGE} .

# Create and copy compiled files, then destroy
docker rm ${CONTAINER}
docker create --name ${CONTAINER} ${IMAGE}
docker cp ${CONTAINER}:/publish ./publish
docker rm ${CONTAINER}