# Simple Docker

Введение в докер. Разработка простого докер образа для собственного сервера.

## Содержание

- [Simple Docker](#simple-docker)
  - [Содержание](#содержание)
  - [Part 1. Готовый докер](#part-1-готовый-докер)
  - [Part 2. Операции с контейнером](#part-2-операции-с-контейнером)
  - [Part 3. Мини веб-сервер](#part-3-мини-веб-сервер)
  - [Part 4. Свой докер](#part-4-свой-докер)
  - [Part 5. Dockle](#part-5-dockle)
  - [Part 6. Базовый Docker Compose](#part-6-базовый-docker-compose)

## Part 1. Готовый докер

Настройка для использования без sudo\
`$ sudo groupadd docker`\
`$ sudo usermod -aG docker $USER`
![no_sudo](../misc/images/1_0.png)

**== Задание ==**\
Взять официальный докер образ с nginx и выкачать его при помощи `docker pull`\
Проверить наличие докер образа через `docker images`\
![start_docker](../misc/images/1_1.png)

Запустить докер образ через docker `run -d [image_id|repository]`\
Проверить, что образ запустился через `docker ps`\
Посмотреть информацию о контейнере через `docker inspect [container_id|container_name]`\
По выводу команды определить и поместить в [отчёт](./part_1/nginx.txt):\
Отчет после маппинга портов - [отчёт](./part_1/nginx_2.txt)\
**размер контейнера**\
`"SizeRootFs": 141523123 Bytes,`\
**список замапленных портов**\
`"Config": {"ExposedPorts": {"80/tcp": {}}},`\
`"HostConfig": {"Ports": {"80/tcp": null}},`\
**ip контейнера**\
`"NetworkSettings": {"IPAddress": "172.17.0.2",}}`

Остановить докер образ через `docker stop [container_id|container_name]`\
Проверить, что образ остановился через `docker ps`\
![container_stop](../misc/images/1_3.png)

Запустить докер с замапленными портами 80 и 443 на локальную машину через команду `run`\
Проверить, что в браузере по адресу localhost:80 доступна стартовая страница nginx\
Перезапустить докер контейнер через docker restart [container_id|container_name]\
Проверить любым способом, что контейнер запустился
![port-mapping](../misc/images/1_4.png)

![browser](../misc/images/1_browser.png)

## Part 2. Операции с контейнером

**== Задание ==**\
Прочитать конфигурационный файл nginx.conf внутри докер образа через команду `exec`\
![docker_conf](../misc/images/2_1.png)

Создать на локальной машине файл [nginx.conf](./part_2/nginx.conf)\
Настроить в нем по пути `/status` отдачу страницы статуса сервера nginx\
Скопировать созданный файл nginx.conf внутрь докер образа через команду `docker cp`\
Перезапустить nginx внутри докер образа через команду `exec`
![config](../misc/images/2_2.png)

Проверить, что по адресу `localhost:80/status` отдается страничка со статусом сервера nginx\
![2-browser](../misc/images/2_browser.png)

Экспортировать контейнер в файл container.tar через команду `export`\
`docker export w_nginx > container.tar`\
Остановить контейнер\
`docker stop w_nginx`\
Удалить образ, не удаляя перед этим контейнеры\
`docker rmi -f nginx:latest`\
Импортировать контейнер обратно через команду `import`\
`docker import container.tar nginx:latest`\
Запустить импортированный контейнер\
`docker run --rm -it -p 80:80 -p 443:443 nginx /bin/bash`\
![import_start](../misc/images/2_4.png)
![import_status](../misc/images/2_5.png)

## Part 3. Мини веб-сервер

**== Задание ==**\
Написать мини сервер на C и FastCgi, который будет возвращать простейшую страничку с надписью Hello World!\
Запустить написанный мини сервер через spawn-cgi на порту 8080\
Написать свой nginx.conf, который будет проксировать все запросы с 81 порта на 127.0.0.1:8080\
Проверить, что в браузере по localhost:81 отдается написанная вами страничка\
Положить файл nginx.conf по пути ./nginx/nginx.conf (это понадобиться позже)

Получаем образ с операционной системой и запускаем его, открыв порт 81:\
`docker pull ubuntu`\
`docker run -it -p 81:81 --name part_3 ubuntu`\
![image](../misc/images/3_1.png)

И устанавливаем необходимые пакеты:\
`apt-get update`\
`apt-get install libfcgi-dev`\
`apt-get install spawn-fcgi`\
`apt-get install nginx`\
`apt-get install gcc`\
`apt-get install nano`\
`apt-get install build-essential`\
`docker cp server/simple_server.c wl:./`

Затем создаём исходный файл мини-сервера [simple-server.c](./server/simple_server.c) и файл конфигурации [nginx.conf](./server/nginx.conf) и копируем их в контейнер:

![src](../misc/images/3_2.png)

Компиляция производится командой\
`gcc -include /usr/include/fcgi_stdio.h simple_server.c -lfcgi`

Запускаем nginx:\
`service nginx start`\
и сервер\
`spawn-fcgi -p 8080 ./a.out `\
Для следующего задания копируем nginx.conf в папку /nginx\
![src](../misc/images/3_3.png)

Результат в браузере:\
![src](../misc/images/3_4.png)

![src](../misc/images/3_5.png)\

## Part 4. Свой докер

**== Задание ==**\
Докер образ находится в файле [Dockerfile](part_4/Dockerfile)

1) собирает исходники [мини сервера](part_4/simple_server.c) на FastCgi из Части 3
2) запускает его на 8080 порту
3) копирует внутрь образа написанный [./nginx/nginx.conf](part_4/nginx.conf)
4) запускает nginx.
nginx можно установить внутрь докера самостоятельно, а можно воспользоваться готовым образом с nginx'ом, как базовым.

Докер образ через docker собирается командой\
`docker build . --tag part_4:latest`\
![build](../misc/images/4_1.png)

и запускается при помощи команды:\
`docker run -it -p 80:81 part_4:latest`\
![start](../misc/images/4_2.png)

Проверить, что по localhost:80 доступна страничка написанного мини сервера\
![hello](../misc/images/4_3.png)

Проверить, что теперь по localhost:80/status отдается страничка со статусом nginx\
![status](../misc/images/4_4.png)

Источник [здесь](https://docs.docker.com/engine/reference/builder/#usage)

## Part 5. Dockle

**== Задание ==**\
Просканировать контейнер из предыдущего задания через dockle [container_id|container_name]\

Устанавливаем Dockle на хост при помощи инструкции\
`VERSION=$(
 curl --silent "https://api.github.com/repos/goodwithtech/dockle/releases/latest" | \
 grep '"tag_name":' | \
 sed -E 's/.*"v([^"]+)".*/\1/' \
) && curl -L -o dockle.deb https://github.com/goodwithtech/dockle/releases/download/v${VERSION}/dockle_${VERSION}_Linux-64bit.deb
$ sudo dpkg -i dockle.deb && rm dockle.deb`\

Запускаем Dockle:\
![run_dockle](../misc/images/5_1.png)

Исправить контейнер так, чтобы при проверке через dockle не было ошибок и предупреждений.

Добавляем скрипты [adduser.sh](part_5/adduser.sh), [install.sh](part_5/install.sh) и [run.sh](part_5/run.sh), которые будет вызывать [Dockerfile](part_5/Dockerfile):\
![Dockerfile](../misc/images/5_2.png)

Докер образ собирается командой `docker build . --tag part_5:no_tag`\
![build](../misc/images/5_3.png)

И запускается как и ранее `docker run -it -p 80:81 part_5:no_tag`\
![run](../misc/images/5_4.png)

Видим, что контейнер запущен\
![status](../misc/images/5_5.png)

В браузере уже знакомый ответ\
![browser](../misc/images/5_browser.png)

И запускаем Dockle:\
![dockle](../misc/images/5_6.png)

## Part 6. Базовый Docker Compose

**== Задание ==**\
Написать файл docker-compose.yml, с помощью которого:

1) Поднять докер контейнер из Части 5 (он должен работать в локальной сети, т.е. не нужно использовать инструкцию EXPOSE и мапить порты на локальную машину)
2) Поднять докер контейнер с nginx, который будет проксировать все запросы с 8080 порта на 81 порт первого контейнера
Замапить 8080 порт второго контейнера на 80 порт локальной машины

Остановить все запущенные контейнеры\
Собрать и запустить проект с помощью команд docker-compose build и docker-compose up\
Проверить, что в браузере по localhost:80 отдается написанная вами страничка, как и ранее

[docker-compose.yml](part_6/docker-compose.yml)\
![docker-compose](../misc/images/6_1a.png)

[default.conf](part_6/default.conf)
![docker-compose](../misc/images/6_1b.png)

Создаём образы командой `docker-compose build`\
![build](../misc/images/6_2.png)

И запускаем
![run](../misc/images/6_3.png)

Видно, что запущены оба контейнера:
![status](../misc/images/6_4.png)

И знакомый ответ сервера:\
![browser](../misc/images/6_browser.png)

И напоследок радикально очищаем диск от результатов нашего творчества:\
`docker rm $(docker ps -aq)` - удаляем все контейнеры \
`docker rmi -f $(docker images -q)` - удаляем образы
