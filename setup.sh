#!/bin/bash

openssl req -new -newkey rsa:2048 -nodes -out ca.csr -keyout ca.key -subj "/C=US/ST=CA/L=Redwood City/O=Mac Experts LLC" && openssl x509 -trustout -signkey ca.key -days 365 -req -in ca.csr -out ca.pem

echo Enter IP/hostname of your MacC2 server:

read server

python3 macro_generator.py -s $server -p 443

docker build -t macc2-docker .

docker volume create macc2

sudo docker run --rm --network="host" -v macc2:/macc2 -ti macc2-docker
