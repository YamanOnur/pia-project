# PIA Project

## Overview

This is the PIA Project repository.

## Setup

- Clone the repository
  ```bash
  git clone https://github.com/YamanOnur/pia-project.git
  cd ./pia-project

## Starting the Services

- To start the services defined in the `docker-compose.yml` file, run the following command:
  ```bash
  docker-compose up -d

## Ensuring the Microservice is Connected to the Database

In some cases, the microservice may start before the database, which can cause connection issues. To resolve this, 
you may need to manually connect the microservice to the database. Follow these steps:

- First, check the status of the running Docker containers to ensure the database is running:
  ```bash
  docker ps -a

- Find the container id of dbcontrolservice
  ```bash
  docker exec -it <dbcontrolservice container_id> bash

- Run the following command:
  ```bash
  python query_server.py

## Deploying the Services on Kubernetes

- Go to the project directory:
  ```bash
  cd ./pia-project
  
- To deploy the services on Kubernetes, use the following command:
  ```bash
  kubectl apply -f ./k8s/

- After deploying the services, you can check the status of the deployments with the following command:
  ```bash
  kubectl get deployments

- To check the status of the running pods, use the following command:
  ```bash
  kubectl get pods

- To check the status of the running services, use the following command:
  ```bash
  kubectl get services

## Conclusion

This project is an illustration of what we have learned during the process and serves as a reference for what we can achieve in the future.

