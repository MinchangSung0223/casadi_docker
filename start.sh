#!/bin/bash

docker rm -f casadi ||

xhost +local:root
 docker  run  --rm -it -d --name casadi --privileged  --volume=/dev:/dev --gpus all --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 casadi bash &&

xhost +local:root
bash multi_terminal.sh

