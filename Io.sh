#!/bin/sh
#
# Interactively run IO in a docker container.
# * The TERM variable allows colors to be displayed correctly.
# * Host networking allows IO and Envoy to bind to local ports.
# * The volume option allows IO to run in the current directory.
#
docker run -ti -e "TERM=$TERM" \
  --network host \
  --volume $(pwd):/io \
  agentio/io -i $@
