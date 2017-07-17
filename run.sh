docker rm -f $(docker ps -qa)
docker build -t mqdockerchris .
docker run \
  --env LICENSE=accept \
  --env MQ_QMGR_NAME=QM1 \
  --publish 1414:1414 \
  --publish 9443:9443 \
  --detach \
  --name mq mqdockerchris
docker logs -f mq
