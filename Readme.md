# Symfony + PHP-FPM + Nginx — локальный запуск и деплой в Kubernetes

Этот проект позволяет запускать Symfony-приложение:

- локально с помощью `docker-compose`
- в Kubernetes через Helm-чарт

---

## Требования

- Docker
- Docker Compose
- Helm
- Kubernetes кластер
- make

---

## Команды Makefile

### Сборка Docker-образа

```bash
make build
```
Создаёт локальный Docker-образ `symfony-php-fpm:latest`

---

### Запуск локально (docker-compose)

```bash
make run-local
```
Запускает Symfony с Nginx локально через docker-compose

### Остановка локального запуска

```bash
make stop-local
```

---

### Деплой в Kubernetes (namespace symfony)

```bash
make run-helm
```
Устанавливает Helm-релиз symfony-app в namespace symfony

### Удаление Helm-релиза

```bash
make stop-helm
```

### Публикация образа в Docker Hub или другом реджистри

```bash
make push
```
Предварительно требуется выполнить логин в реджистри:
```bash
docker login <REGISTRY_URL>
```

## Проверка работоспособности

### Подключение к сервису

```
kubectl -n symfony port-forward svc/symfony-app 8080:80 --address=0.0.0.0
```
Теперь приложение доступно по адресу:
http://<k8s-worker-node-ip-address>:8080
