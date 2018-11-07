#!/usr/bin/env bash

#usage(){
#  echo "$0 - a script to build nexus-oss rpms"
#  echo "Usage: $0 <spec>"
#}

#if [ -z "$1" ]; then
#  usage
#  exit 1
#fi

DIST=$(dirname $(readlink -f $0))/dist
#SPEC=$(readlink -f $1)
SPEC=redis.spec
VERSION=$(grep "^Version\:" $SPEC|awk '{print $2}')

if [ ! -f $DIST/SOURCES/redis-$VERSION.tar.gz ]; then
  [ ! -d $DIST/SOURCES ] && mkdir -p $DIST/SOURCES
  wget https://codeload.github.com/antirez/redis/tar.gz/$VERSION -O $DIST/SOURCES/redis-$VERSION.tar.gz 
  if [ "$?" -ne "0" ]; then
    rm -rf $DIST/SOURCES/redis-$VERSION.tar.gz
    echo "download redis-$VERSION.tar.gz faild!"
    exit 1
  fi
fi

mkdir -p $DIST/{BUILD,BUILDROOT,RPMS}
rpmbuild --verbose \
  --define "_topdir $DIST" \
  --define "_rpmdir $DIST/RPMS" \
  -bb "$SPEC"

