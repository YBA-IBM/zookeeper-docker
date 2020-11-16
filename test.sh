#!/bin/bash

set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** FUNCTIONAL TEST(S) *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW Zookeeper testing: $ANSI_RESET"
docker run --name some-zookeeper --restart always -d quay.io/ibmz/zookeeper:3.6.2
docker run --name some-app --link some-zookeeper:zookeeper -d quay.io/ibmz/ubuntu:18.04
#docker run -it --rm --link some-zookeeper:zookeeper quay.io/ibmz/zookeeper:3.6.2 zkCli.sh -server zookeeper
#quit
docker stop some-zookeeper && docker rm some-zookeeper
docker run -e "ZOO_INIT_LIMIT=10" --name some-zookeeper --restart always -d quay.io/ibmz/zookeeper:3.6.2
docker stop some-zookeeper && docker rm some-zookeeper
docker run -d --name some-zookeeper --restart always -e ZOO_LOG4J_PROP="INFO,ROLLINGFILE" quay.io/ibmz/zookeeper:3.6.2
docker stop some-zookeeper && docker rm some-zookeeper


echo -e "\n $ANSI_GREEN *** FUNCTIONAL TEST(S) COMPLETED SUCESSFULLY *** $ANSI_RESET \n"

