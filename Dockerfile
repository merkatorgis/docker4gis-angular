FROM node:18.2.0 as builder

# This may come in handy.
ONBUILD ARG DOCKER_USER
ONBUILD ENV DOCKER_USER=$DOCKER_USER

RUN mkdir /src
WORKDIR /src
ONBUILD COPY . .
ONBUILD RUN npm install
ONBUILD RUN npm run build

FROM docker4gis/serve:v0.0.4
ENV SINGLE=true
RUN rm -rf /wwwroot

ONBUILD ARG build_dir
ONBUILD COPY --from=builder ${build_dir} /wwwroot

# Extension template, as required by `dg component`.
COPY template /template/
# Make this an extensible base component; see
# https://github.com/merkatorgis/docker4gis/tree/npm-package/docs#extending-base-components.
# COPY conf/.docker4gis /.docker4gis
COPY build.sh /.docker4gis/build.sh
# COPY run.sh /.docker4gis/run.sh
ONBUILD COPY conf /tmp/conf
ONBUILD RUN touch /tmp/conf/args
ONBUILD RUN cp /tmp/conf/args /.docker4gis
