#!/bin/sh

#Start docker containers
docker compose up -d
echo "Program launching..."
#Wait the system starts
sleep 30s

echo "Press Enter to post devices stream.."
read
#Post the stream configuration
curl -X POST 'http://localhost:8080/admin/api/v1/eventstreams' -H 'Content-Type: text/turtle' -d '@./configs/devices/devices.ttl'
if [ $? != 0 ]
    then exit $?
fi

echo "Press Enter to post observations stream.."
read
#Post the stream configuration
curl -X POST 'http://localhost:8080/admin/api/v1/eventstreams' -H 'Content-Type: text/turtle' -d '@./configs/observations/observations.ttl'
if [ $? != 0 ]
    then exit $?
fi

echo "Press Enter to post devices time-based view.."
read
#Post the stream configuration
curl -X POST 'http://localhost:8080/admin/api/v1/eventstreams/devices/views' -H 'Content-Type: text/turtle' -d '@./configs/devices/devices.by-time.ttl'
if [ $? != 0 ]
    then exit $?
fi

echo "Press Enter to post devices geospatial-based view.."
read
#Post the stream configuration
curl -X POST 'http://localhost:8080/admin/api/v1/eventstreams/devices/views' -H 'Content-Type: text/turtle' -d '@./configs/devices/devices.by-location.ttl'
if [ $? != 0 ]
    then exit $?
fi


echo "Press Enter to post observations time-based view.."
read
#Post the stream configuration
curl -X POST 'http://localhost:8080/admin/api/v1/eventstreams/water-quality-observations/views' -H 'Content-Type: text/turtle' -d '@./configs/observations/observations.by-time.ttl'
if [ $? != 0 ]
    then exit $?
fi


#Start client for observations
echo "Press Enter to start client for observations."
read
docker compose up ldio-workbench-observations -d

#Start client for devices
echo "Press Enter to start client for devices."
read
docker compose up ldio-workbench-devices -d


echo "Press Enter to End"
read
docker rm -f $(docker ps -a -q)