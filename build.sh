#!/bin/bash

# This one only builds the base component, since we leave serve's build.sh
# untouched in the image.
docker image build \
	-t "$IMAGE" .
