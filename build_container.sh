#!/usr/bin/env bash

docker build -t devenv                      \
             --build-arg USERNAME=$(whoami) \
             --build-arg UID=$(id -u)       \
             --build-arg GID=$(id -g) .
