#!/bin/sh
registry=$1
name=$2
tag=$3
curl -s -I -w "%{http_code}" "http://${registry}/v2/${name}/manifests/$(
    curl -sSL -I \
         -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
         "http://${registry}/v2/${name}/manifests/${tag}" \
    | awk '$1 == "Docker-Content-Digest:" { print $2 }' \
    | tr -d $'\r' \
)" | grep -sq "200 OK"
