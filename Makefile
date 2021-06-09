NAME := firestrike-server
TAG := $(shell git log -1 --pretty=%h)
NAMESPACE := 602245705509.dkr.ecr.us-west-2.amazonaws.com

SVN_URL := svn://172.20.1.248/thewar/branches/ReleaseQA/TheWar-Server

PROTOTYPE_DIR := prototype
FRAMEWORK_DIR := framework
CLIBS_DIR := clibs
CONFIG_TEMPLATE_DIR := config_template
BUILD_SCRIPT := buildscript

PWD := $(shell pwd)

.PHONY : all deps base build build-ubuntu build-centos

all : deps build

deps : ${PROTOTYPE_DIR} ${FRAMEWORK_DIR} ${CLIBS_DIR} ${CONFIG_TEMPLATE_DIR} ${BUILD_SCRIPT}

build-ubuntu : deps
	docker build -t ${NAMESPACE}/${NAME}:latest -t ${NAMESPACE}/${NAME}:${TAG} -t ${NAMESPACE}/${NAME}:ubuntu -f Dockerfile.ubuntu .

build-centos: deps
	docker build -t ${NAMESPACE}/${NAME}:latest -t ${NAMESPACE}/${NAME}:${TAG} -t ${NAMESPACE}/${NAME}:centos -f Dockerfile.centos .

build : build-ubuntu

push :
	docker push ${NAMESPACE}/${NAME}

${CONFIG_TEMPLATE_DIR} :
	svn export --force ${SVN_URL}/server-single/config/config_template ${CONFIG_TEMPLATE_DIR}

${PROTOTYPE_DIR} :
	svn export --force ${SVN_URL}/server-single/node-x ${PROTOTYPE_DIR}/node-x
	svn export --force ${SVN_URL}/server-single/script ${PROTOTYPE_DIR}/script
	svn export --force ${SVN_URL}/server-single/data ${PROTOTYPE_DIR}/data
	svn export --force ${SVN_URL}/server-single/bootinit ${PROTOTYPE_DIR}/bootinit
	# Remove binary libs in bootinit/clibs. We'll rebuild c clibs later.
	# Those binaries should probably not be in svn to begin with.
	# Removing these only to upload less to docker context
	rm -rf ${PROTOTYPE_DIR}/bootinit/clibs/*

${FRAMEWORK_DIR} :
	svn export --force ${SVN_URL}/framework ${FRAMEWORK_DIR}

${CLIBS_DIR} :
	svn export --force ${SVN_URL}/clibs ${CLIBS_DIR}

${BUILD_SCRIPT} :
	svn export --force ${SVN_URL}/buildscript .

clean :
	rm -frv ${PROTOTYPE_DIR} ${FRAMEWORK_DIR} ${CLIBS_DIR} ${CONFIG_TEMPLATE_DIR} Dockerfile run_dev.sh run_prod.sh
