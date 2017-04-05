#!/usr/bin/env bash
docker build -t bash_it:latest .
docker-compose -p example up
docker-compose -p example down
docker rmi bash_it:latest
