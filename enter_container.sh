#!/usr/bin/env bash

docker run --rm -it -v $1 -v $2 -h devenv devenv
