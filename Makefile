build:
	docker build -t symfony-php-fpm .

run-local: build
	docker-compose up --build -d

run-helm:
	helm upgrade --namespace symfony --create-namespace --install symfony-app ./symfony-chart

stop-local:
	docker-compose down

stop-helm
	helm -n symfony uninstall symfony-app

local-registry: build
	docker tag symfony-php-fpm:latest localhost/symfony-php-fpm:latest
	docker save -o symfony.tar localhost/symfony-php-fpm:latest
	ctr --namespace k8s.io images import symfony.tar
