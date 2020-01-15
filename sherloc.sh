#!/bin/bash
docker run -v /var/run/docker.sock:/var/run/docker.sock -it sherloc:v0.1 $1 $2 $3
