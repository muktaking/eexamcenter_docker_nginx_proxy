echo stoping node_app
sudo docker stop node_app
sudo docker stop mongodb

echo restoring node_app
sudo docker run --rm --volumes-from node_app -v $(pwd)/backup:/backup ubuntu bash -c "cd /home && tar xvf /backup/<backup_file_name>.tar --strip 1"
echo restoring mongodb
sudo docker run --rm --volumes-from mongodb -v $(pwd)/backup:/backup ubuntu bash -c "cd /home && tar xvf /backup/<backup_file_name>.tar --strip 1"

echo starting containers
sudo docker start node_app
sudo docker start mongodb

