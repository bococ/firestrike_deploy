#!/usr/bin/env bash
# Creates a repository

REPOSITORY_NAME=$1

aws ecr create-repository --repository-name ${REPOSITORY_NAME}
