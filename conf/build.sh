#!/bin/bash

# Install build dependencies.
npm install

# Build artefacts from sources.
npm build

json_value() {
    local json_file=$1
    local json_path=$2

    node --print "require('$json_file').$json_path"
}

# Find out which directory contains the build artefacts that we need to serve.
project=$(json_value package.json name)
json_path=projects.$project.architect.build.options.outPath
outPath=$(json_value angular.json "$json_path")

# Make that directory the /wwwroot that will get served.
rm -rf /wwwroot
mv "$outPath" /wwwroot

# Remove all sources; we only needed them for the build.
cd /
rm -rf /src
