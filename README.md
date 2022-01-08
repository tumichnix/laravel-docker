# laravel-docker
Laravel basic docker container 

## run

```
docker run -p 8080:8080 -v ${PWD}:/var/www/html --name laravel tumichnix/laravel:latest
```

## build

```
docker build -t tumichnix/laravel:latest .
```
