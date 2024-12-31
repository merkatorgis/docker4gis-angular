FROM node:22.12.0-alpine3.21

# The source directory is given as a build argument.
ONBUILD ARG SRC
ONBUILD ENV SRC=$SRC

WORKDIR /src

# Install dependencies.
ONBUILD COPY $SRC/package.json $SRC/package-lock.json ./
ONBUILD RUN npm install

# Build the application.
ONBUILD COPY $SRC .
ONBUILD RUN npm run build

# Make /build contain the build artefacts that were written to the first
# "outputPath" entry in the angular.json file.
ONBUILD RUN mv "$(sed -rn 's/.*"outputPath": "(.*)".*/\1/p' angular.json | head -n 1)" /build
