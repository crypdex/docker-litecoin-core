#!/usr/bin/env bash

SERVICE="litecoin-core"
#VERSION=

# Build and push builds for these architectures
for arch in x86_64 arm64v8; do
    docker build -f ${VERSION}/Dockerfile.${arch} -t crypdex/${SERVICE}:${arch}-${VERSION} ${VERSION}/.
    # Push both images, version and "latest"
    docker push crypdex/${SERVICE}:${arch}-${VERSION}
    docker push crypdex/${SERVICE}:${arch}
done

# Now create a manifest that points from latest to the specific architecture
rm -rf ~/.docker/manifests/*

# version
docker manifest create crypdex/${SERVICE}:${VERSION} crypdex/${SERVICE}:x86_64-${VERSION} crypdex/${SERVICE}:arm64v8-${VERSION}
docker manifest push crypdex/${SERVICE}:${VERSION}

# latest
#docker manifest create crypdex/${service}:latest crypdex/${service}:x86_64-latest crypdex/${service}:arm64v8-latest
#docker manifest push crypdex/${service}:latest

