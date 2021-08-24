#!/bin/sh

ORGNAME=catseye
EXENAME=hastec
VERSION=0.5.5.1-ce1
IMAGE=$ORGNAME/$EXENAME:$VERSION

IMAGENAME=$EXENAME

docker container prune -f
docker rmi ${ORGNAME}/${IMAGENAME}:${VERSION}
docker rmi ${IMAGENAME}
