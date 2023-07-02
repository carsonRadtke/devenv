#!/usr/bin/env bash

docker run --rm -it                         \
  -v /Users/carson/code:/home/carson/code   \
  -h devenv                                 \
  devenv
