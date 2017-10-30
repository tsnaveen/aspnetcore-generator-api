# Build stage

#   get base image 
FROM microsoft/aspnetcore-build:2 AS build-env

WORKDIR /generator

#   restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj
COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

#   copy src
COPY . .

#   test
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test tests/tests.csproj

#   publish
RUN dotnet publish api/api.csproj -o /publish

# Runtime stage
FROM microsoft/aspnetcore:2
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]

# Integration stage
FROM microsoft/aspnetcore-build:2 as integration-env

WORKDIR /integration
#   restore
COPY integration/integration.csproj ./integration/
RUN dotnet restore integration/integration.csproj
#   copy src
COPY . .
#   integration test
RUN dotnet test integration/integration.csproj

