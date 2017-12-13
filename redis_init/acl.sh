#!/bin/sh
REDIS_BIN=redis-cli
HOST=127.0.0.1
PORT=6379

for t in `seq 5 20`;do
for id in `seq 1 20`;do
if [ $(($id%10)) = '0' ];then
    echo "id:::  $id...."
    echo "topic:::  $t...."
    ${REDIS_BIN} -h ${HOST} -p ${PORT} hset mqtt_acl:user${id} topic/device_user$id/t_$t 3
    sleep 1
    continue
else
    ${REDIS_BIN} -h ${HOST} -p ${PORT} hset mqtt_acl:user${id} topic/device_user$id/t_$t 3
fi
done
done

