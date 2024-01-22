#!/bin/bash

CONFIG=~/.sqldeveloper
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.${USER}.xauth

if [ ! -d "$CONFIG" ]
then
	mkdir "$CONFIG"
fi

xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -ti $TNS -v $CONFIG:/root -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e DISPLAY=$DISPLAY -e XAUTHORITY=$XAUTH oracle/sqldeveloper:23-ol8
