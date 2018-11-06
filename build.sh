#!/usr/bin/env bash

usage(){
  echo "$0 - a script to build nexus-oss rpms"
  echo "Usage: $0 <spec>"
}

if [ -z "$1" ]; then
  usage
  exit 1
fi

DIST=$(dirname $(readlink -f $0))/dist
SPEC=$(readlink -f $1)

mkdir -p $DIST/{BUILD,BUILDROOT,RPMS}
rpmbuild --verbose \
  --define "_topdir $DIST" \
  --define "_rpmdir $DIST/RPMS" \
  -bb "$SPEC"

