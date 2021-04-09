#!/bin/bash
# patch version 1, CVE-2019-5736
set -ex

VERSION=$1
ARCH=$2
if [ "$ARCH" == "amd64" ]; then
    DOCKERARCH="x86_64"
    URL="https://download.docker.com/linux/static/stable/${DOCKERARCH}/docker-${VERSION}-ce.tgz"
    COMPLETION_URL="https://raw.githubusercontent.com/docker/cli/v${VERSION}-ce/contrib/completion/bash/docker"
fi

DEST="./images/10-docker-${VERSION}${SUFFIX}"

mkdir -p $DEST
curl -sL ${URL} | tar xzf - -C $DEST
curl -sL -o $DEST/docker/completion ${COMPLETION_URL} 
mv $DEST/docker $DEST/engine

curl -sL -o $DEST/engine/docker-runc https://github.com/rancher/runc-cve/releases/download/CVE-2019-5736-build2/runc-v${VERSION}-${ARCH}
