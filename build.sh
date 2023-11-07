#!/bin/bash
docker build -t react-app .
docker-compose down || true
docker-compose up -d