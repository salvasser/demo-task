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
Запускает `Symfony` с `Nginx` локально через `docker-compose`

### Остановка локального запуска

```bash
make stop-local
```

---

### Деплой в Kubernetes (namespace `symfony`)

```bash
make run-helm
```
Устанавливает Helm-релиз symfony-app в namespace `symfony`

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
`http://<k8s-worker-node-ip-address>:8080`

---

## Пояснение к параметрам чарта values.yaml

| Параметр                    | Описание                                                                 |
|-----------------------------|--------------------------------------------------------------------------|
| `replicaCount`              | Количество pod-ов в `Deployment`                                        |
| `image.phpFpm.repository`   | Образ PHP-FPM с Symfony-приложением                                     |
| `image.phpFpm.tag`          | Тег Docker-образа                                                       |
| `image.phpFpm.pullPolicy`   | Политика скачивания образа (`Always`, `IfNotPresent`, `Never`)          |
| `image.nginx.repository`    | Базовый образ Nginx                                                     |
| `image.nginx.tag`           | Тег Nginx-образа                                                        |
| `service.type`              | Тип Kubernetes-сервиса (`ClusterIP`, `NodePort`, `LoadBalancer`)        |
| `service.port`              | Порт, на котором будет доступно приложение                              |
| `nginx.config`              | Содержимое `nginx.conf` (в формате ConfigMap → монтируется внутрь)       |
