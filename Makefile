REGISTRY = salvasser
RELEASE = symfony-app
NAMESPACE = symfony
IMAGE = symfony-php-fpm

build:
	docker build -t ${IMAGE} .

run-local: build
	docker-compose up --build -d

run-helm: build
	helm upgrade --namespace ${NAMESPACE} --create-namespace --install ${RELEASE} ./symfony-chart

stop-local:
	docker-compose down

stop-helm:
	helm -n ${NAMESPACE} uninstall ${RELEASE}

push: build
	docker tag ${IMAGE}:latest ${REGISTRY}/${IMAGE}:latest
	docker push ${REGISTRY}/${IMAGE}:latest
