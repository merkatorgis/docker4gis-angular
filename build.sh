#!/bin/bash

angular_json=$(find . -name angular.json | head -n 1)
SRC=$(dirname "$angular_json")

docker image build \
	--build-arg DOCKER_USER="$DOCKER_USER" \
	--build-arg SRC="$SRC" \
	-t "$IMAGE" .
