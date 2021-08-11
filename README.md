## Overview
Technical challenge to containerise a small Go app and provide a Kubernetes Deployment manifest.

## Fixes, Changes, Improvements
`main.go`
- Listen on all interfaces
- Fix function call for optimization truth endpoint
- Cosmetic formatting

`Dockerfile`
- Refactor as a multistage build
- Parent image pinned to a specific Golang version to promote better build repeatability
- Remove redundant package install (`git`)
- Build minimal, static binary - strip debugging and symbol table
- Generate lean, single layer image
- Configure to run as non-root

## Build & Deploy Instructions
Required tools:
- Docker
- kubectl
- make
 
Tasks related to the building/deploying of the image are captured in the `Makefile`.
Docker Hub serves as the registry for builds. The following environment variables must be exported prior to invoking make:

 - `DOCKER_HUB_REPO`
 - `DOCKER_HUB_TOKEN`
 - `DOCKER_HUB_USERNAME`

To build/push the image locally, simply run the following:
```
make build
make push
```
The `apply` target will deploy a simple Deployment & Service to your kubectl current context (`default` Namespace).
```
make apply
```
A GitHub workflow is also included in the repo which leverages a couple of targets in the `Makefile`. Ensure you have added the above variables as Actions secrets after forking the repo.
