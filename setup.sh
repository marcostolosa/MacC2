#!/bin/bash

openssl req -new -newkey rsa:2048 -nodes -out ca.csr -keyout ca.key && openssl x509 -trustout -signkey ca.key -days 365 -req -in ca.csr -out ca.pem

echo Enter IP/hostname of your MacC2 server:

read server

echo Enter listening port for your MacC2 server:

read port

python3 macro_generator.py -s $server -p $port

docker build -t macc2-docker .

docker volume create macc2

sudo docker run --rm -p 443:443 -v macc2:/macc2:ro -ti macc2-docker
