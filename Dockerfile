FROM docker4gis/serve:v0.0.11
ENV SINGLE=true

# This may come in handy.
ONBUILD ARG DOCKER_USER
ONBUILD ENV DOCKER_USER=$DOCKER_USER

RUN mkdir /src
WORKDIR /src

ONBUILD COPY . .
ONBUILD RUN npm install
ONBUILD RUN npm run build

# Replace /wwwroot with the build artefacts that were written to the first
# "outputPath" entry in angular.json.
RUN rm -rf /wwwroot
ONBUILD RUN mv "$(sed -rn 's/.*"outputPath": "(.*)".*/\1/p' angular.json | head -n 1)" /wwwroot
ONBUILD WORKDIR /
ONBUILD RUN rm -rf /src

# Extension template, as required by `dg component`.
# Replace serve's template with our own.
RUN rm -rf /template
COPY template /template/
# Make this an extensible base component; see
# https://github.com/merkatorgis/docker4gis/tree/npm-package/docs#extending-base-components.

# Keep serve's instances of these.
# COPY conf/.docker4gis /.docker4gis
# COPY build.sh /.docker4gis/build.sh
# COPY run.sh /.docker4gis/run.sh

# Redo these to actually get them done on build.
ONBUILD COPY conf /tmp/conf
ONBUILD RUN touch /tmp/conf/args
ONBUILD RUN cp /tmp/conf/args /.docker4gis
