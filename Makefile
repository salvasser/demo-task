build:
	docker build -t symfony-php-fpm .

run: build
	docker-compose up --build -d

stop:
	docker-compose down