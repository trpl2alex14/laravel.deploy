#!/bin/bash

cd ~/docker
docker-compose up -d certbot
sleep 5m
docker-compose exec webserver nginx -s reload