#!/bin/sh
#
# Run IO in a docker container.
# * The detach option runs the container in the background.
# * Host networking allows IO and Envoy to bind to local ports.
# * The volume option allows IO to run in the current directory.
#
docker run --detach \
  --network host \
  --volume $(pwd):/io \
  agentio/io $@
