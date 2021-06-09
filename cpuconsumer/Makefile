NAME := cpuconsumer
TAG := $(shell git log -1 --pretty=%h)
NAMESPACE := 688532141779.dkr.ecr.ap-southeast-1.amazonaws.com

.PHONY : build push

build :
	docker build --no-cache -t ${NAMESPACE}/${NAME}:latest -t ${NAMESPACE}/${NAME}:${TAG} -f Dockerfile .

push :
	docker push ${NAMESPACE}/${NAME}
