#!/bin/sh

#Start docker containers
docker compose up -d
echo "Program launching..."
#Wait the system starts
sleep 30s

sleep 5s
echo "Post devices stream.."
#Post the stream configuration
curl -X POST 'http://localhost:8080/admin/api/v1/eventstreams' -H 'Content-Type: text/turtle' -d '@./configs/devices/devices.ttl'
if [ $? != 0 ]
    then exit $?
fi


sleep 5s
echo "Post observations stream.."
#Post the stream configuration
curl -X POST 'http://localhost:8080/admin/api/v1/eventstreams' -H 'Content-Type: text/turtle' -d '@./configs/observations/observations.ttl'
if [ $? != 0 ]
    then exit $?
fi


sleep 5s
echo "Post devices time-based view.."
#Post the stream configuration
curl -X POST 'http://localhost:8080/admin/api/v1/eventstreams/devices/views' -H 'Content-Type: text/turtle' -d '@./configs/devices/devices.by-time.ttl'
if [ $? != 0 ]
    then exit $?
fi

sleep 5s
echo "Post observations time-based view.."
#Post the stream configuration
curl -X POST 'http://localhost:8080/admin/api/v1/eventstreams/water-quality-observations/views' -H 'Content-Type: text/turtle' -d '@./configs/observations/observations.by-time.ttl'
if [ $? != 0 ]
    then exit $?
fi

#Start client for observations
sleep 5s
echo "Start client for observations."
docker compose up ldio-workbench-observations -d

#Start client for devices
sleep 5s
echo "Start client for devices."
docker compose up ldio-workbench-devices -d