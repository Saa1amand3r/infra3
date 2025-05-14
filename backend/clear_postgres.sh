#!/bin/bash
sudo docker stop $(docker ps -a -q)
sudo docker container prune
sudo docker volume rm backend_eg-db-data
