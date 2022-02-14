# laravel-docker

Laravel basic docker container with nginx

## run

```
docker run -p 8080:80 -v ${PWD}:/var/www/html --name laravel tumichnix/laravel:v2.0.0
```

## build

```
docker build -t tumichnix/laravel:v2.0.0 .
```
