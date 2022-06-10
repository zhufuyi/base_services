#!/bin/bash

echo "正在构建docker镜像......"

docker build -t cloudera-exporte:latest .

echo "构建镜像结束"

docker-compose down

sleep 1

docker-compose up -d
