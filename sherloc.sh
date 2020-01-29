#!/bin/bash

if [[ "$#" -ne 3 && "$1" != "help" ]]
then
    echo "Incorrect number of parapeters passed into script"
    echo "Correct format './sherloc scan <option> <argument>'"
    exit 1
fi

docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD/image_file:/image_file -it docker.artifactory.euw.platformservices.io/docker/morrist/sherloc:v0.2 $1 $2 $3

