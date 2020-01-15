#!/bin/bash
#docker run -v /var/run/docker.sock:/var/run/docker.sock -it docker.artifactory.euw.platformservices.io/docker/morrist/sherloc:v0.1 $1 $2 $3
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD/test_image_file:/test_image_file -it sherloc $1 $2 $3
