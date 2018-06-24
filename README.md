# Infinite loop app deploy using docker-compose
Docker compose configured to start 4 containers:
* ruby:alpine based container that run an infinite loop application
* prom/prometheus based container for metrics
* google/cadvisor based container for metrics collection
* grafana/grafana based container for metrics visualisation

Requires `docker-ce` and `docker-compose` installed
In order to start environment, run
    docker-compose up

Grafana will be available on <http://localhost:3000>

---
# Implementation details
Grafana dashboard and datasource are imported on container start via `grafana/setup.sh` from `grafana/dashboard/docker_containers.json` and `grafana/datasource/Prometheus.json` respectivly.

Prometheus configuration (`prometheus/prometheus.yml`) is mounted inside prometheus container.

Grafana and Prometheus also have data volumes configured

Container with infinite loop app is built from `Dockerfile`
