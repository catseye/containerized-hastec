#!/bin/sh

ORGNAME=catseye
EXENAME=hastec
VERSION=0.5.5.1-ce1
IMAGE=$ORGNAME/$EXENAME:$VERSION

IMAGENAME=$EXENAME
DOCKERFILE=`pwd`/Dockerfile

docker build -f ${DOCKERFILE} -t ${IMAGENAME} .
docker tag ${IMAGENAME} ${ORGNAME}/${IMAGENAME}:${VERSION}
docker images | grep ${IMAGENAME}
