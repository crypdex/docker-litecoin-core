#!/usr/bin/env bash

##########################################
# Run this script with Makefile from root
# VERSION=0.17 make release
##########################################

#VERSION=
SERVICE="litecoin-core"
ARCH="arm64v8 x86_64"
# This should alway track the latest version
VERSION='0.17'

# Build and push builds for these architectures
for arch in ${ARCH}; do
    docker build -f ${VERSION}/Dockerfile.${arch} -t crypdex/${SERVICE}:${VERSION}-${arch} ${VERSION}/.
    docker push crypdex/${SERVICE}:${VERSION}-${arch}
done

# Now create a manifest that points from latest to the specific architecture
rm -rf ~/.docker/manifests/*

# version
docker manifest create crypdex/${SERVICE}:${VERSION} crypdex/${SERVICE}:${VERSION}-x86_64 crypdex/${SERVICE}:${VERSION}-arm64v8
docker manifest push crypdex/${SERVICE}:${VERSION}

