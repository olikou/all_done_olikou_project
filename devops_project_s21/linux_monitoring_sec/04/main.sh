#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./04"
elif [[ $CURRENT_DIR = */04 ]]; then
BASE_DIR="."
fi

# 200 "OK"
# "Успешно". Запрос успешно обработан. 
# 201 "Created"
# "Создано". Запрос успешно выполнен и в результате был создан ресурс.
# 400 "Bad Request"
# "Плохой запрос". Сервер не понимает запрос из-за неверного синтаксиса.
# 401 "Unauthorized"
# "Неавторизованно". Для получения запрашиваемого ответа нужна аутентификация.
# 403 "Forbidden"
# "Запрещено". У клиента нет прав доступа к содержимому, сервер отказывается дать надлежащий ответ.
# 404 "Not Found"
# "Не найден". Сервер не может найти запрашиваемый ресурс.
# 500 "Internal Server Error"
# "Внутренняя ошибка сервера". Сервер столкнулся с ситуацией, которую он не знает как обработать.
# 501 "Not Implemented"
# "Не выполнено". Метод запроса не поддерживается сервером и не может быть обработан.
# 502 "Bad Gateway"
# "Плохой шлюз". Сервер, во время работы в качестве шлюза получил недопустимый ответ.
# 503 "Service Unavailable"
# "Сервис недоступен". Сервер не готов обрабатывать запрос.

function gen_response {
    code=(200 201 400 401 403 404 500 501 502 503)
    echo ${code[$(($RANDOM % 10))]}
}

function gen_date {
    echo $(date +'%d/%b/%Y:%T %z' --date="+$1 minute +$2 day")
}

function gen_method {
    method=("GET" "POST" "PUT" "PATCH" "DELETE")
    echo ${method[$(($RANDOM % 5))]}
}

function gen_protocol {
    protocol=("HTTP/0.9" "HTTP/1.0" "HTTP/1.1" "HTTP/2.0")
    echo ${protocol[$(($RANDOM % 4))]}
}

function gen_resourse {
    resourse=("/index.html" "/index" "/news" "/about" "/search/" "/articles/post")
    echo ${resourse[$(($RANDOM % 6))]}
}

function gen_agent {
    agent=("Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
    echo ${agent[$(($RANDOM % 6))]}
}

for log in {1..5}; do
    count_logs=$( shuf -i 100-1000 -n 1 )
    log_name="$BASE_DIR/nginx_combined_$log.log"

    gen_ip=$(($RANDOM % 255)).$(($RANDOM % 255)).$(($RANDOM % 255)).$(($RANDOM % 255))
    gen_size=$( shuf -i 1-1024 -n 1 )
    
    # 192.168.33.1 - - [15/Oct/2019:19:41:46 +0000] "GET / HTTP/1.1" 200 396 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36"
    # '$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for"';
    for ((i = 1; i < $count_logs; i++)); do
        echo "$gen_ip - $USER [$( gen_date $count_logs $log ) ] \"$( gen_method ) / $( gen_protocol )\" $( gen_response ) $gen_size \"-\" \"$(gen_agent)\"" >> $log_name
    done
done
