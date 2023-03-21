#!/bin/bash

build_dir=$build_dir

docker image build \
	--build-arg DOCKER_USER="$DOCKER_USER" \
	--build-arg build_dir="$build_dir" \
	-t "$IMAGE" .
