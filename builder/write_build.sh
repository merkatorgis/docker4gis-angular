#!/bin/bash
set -x

# Find the first outputPath in angular.json
projects="require('./angular.json').projects"
project="Object.values($projects)[0]"
outputPathQuery="$project.architect.build.options.outputPath"
outputPath=$(node --print "$outputPathQuery")

dist=$outputPath
if [ -d "$outputPath/browser" ]; then
    dist+=/browser
fi
mv "$dist" "$BUILD_DESTINATION"

if [ -d "$outputPath/assets" ]; then
    cp -r "$outputPath/assets"/* "$BUILD_DESTINATION"/
fi
