#!/bin/sh

sudo docker stop node_app
sudo docker stop mongodb

echo removing older than 7 days files

find /backup/ -type f -name '*.tar' -mtime +7 -exec rm {} \;

echo backingup node_app volumes
docker run --rm --volumes-from node_app -v $(pwd)/backup:/backup ubuntu tar cvf /backup/$(date +'%M_%H_%d_%m_%Y')_node_app.tar /home

echo backingup mongodb volumes
docker run --rm --volumes-from mongodb -v $(pwd)/backup:/backup ubuntu tar cvf /backup/$(date +'%M_%H_%d_%m_%Y')_mongodb.tar /data


echo backup successful

echo staring docker images

sudo docker start mongodb
sudo docker start node_app

#echo uploading to dropbox
#./dropbox_uploader.sh upload /root/backup/ /onlinepgdexam/

# to run this at cron job please add following liens in your crontab(crontab -e)
# 0 3 * * * /root/backup.sh
# copy backup.sh to root directory