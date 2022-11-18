#!/bin/bash

# export .env variables
export $(grep -v '^#' ../.env | xargs)

# Create folders structure
if [ -d "$KTH_DUMP_PATH/kth_data_dump" ]
then
  echo "$KTH_DUMP_PATH/kth_data_dump already exists"
else
  mkdir $KTH_DUMP_PATH/kth_data_dump
  echo "$KTH_DUMP_PATH/kth_data_dump created"
fi

if [ -d "$KTH_DUMP_PATH/kth_data_dump/kth_db" ]
then
  echo "$KTH_DUMP_PATH/kth_data_dump/kth_db already exists"
else
  mkdir $KTH_DUMP_PATH/kth_data_dump/kth_db
  echo "$KTH_DUMP_PATH/kth_data_dump/kth_db created"
fi

if [ -d "$KTH_DUMP_PATH/kth_data_dump/kth_os" ]
then
  echo "$KTH_DUMP_PATH/kth_data_dump/kth_os already exists"
else
  mkdir $KTH_DUMP_PATH/kth_data_dump/kth_os
  echo "$KTH_DUMP_PATH/kth_data_dump/kth_os created"
fi

if [ -d "$KTH_DUMP_PATH/kth_data_dump/kth_files" ]
then
  echo "$KTH_DUMP_PATH/kth_data_dump/kth_files already exists"
else
  mkdir $KTH_DUMP_PATH/kth_data_dump/kth_files
  echo "$KTH_DUMP_PATH/kth_data_dump/kth_files created"
fi

# dump DB

echo "Saving all the metadata on the host at $KTH_DUMP_PATH/kth_data_dump/kth_db..."
TODAY=$(date +"%Y_%m_%d_%H_%M")
docker exec $POSTGRES_CONTAINER pg_dumpall -U $PG_USER > $KTH_DUMP_PATH/kth_data_dump/kth_db/backup_kth_db_${TODAY}.sql


# # saving files in the host
# echo "Saving files on the host in $KTH_DUMP_PATH/kth_data_dump/kth_files/..."
# docker cp kth-invenio_web-ui_1:/opt/invenio/var/instance/data/. $KTH_DUMP_PATH/kth_data_dump/kth_files/

# # take a snapshot for OS
# echo "checking if repo already exists or not ..."
# REPO=$(docker exec $SEARCH_ENGIN_CONTAINER curl -s -X GET "localhost:9200/_cat/repositories" | wc -l)

# if [ $REPO -eq 0 ]
# then
#   echo "Creating the repo..."
#   docker exec $SEARCH_ENGIN_CONTAINER curl -s -X PUT -H "Content-Type: application/json" -d '{ "type": "fs", "settings": {"location": "/mnt/backup_kth_os", "compress": true } }' http://localhost:9200/_snapshot/backup_kth_os
#   echo
# else
#   echo "Repo exists..."
# fi

# # checking number of snapshot to create the new snapshot with the correct name 'snapshot_<#number>'
# echo "Checking number of snapshots..."
# SNAPSHOTS=$(docker exec kth-invenio_es_1 curl -s -X GET "localhost:9200/_cat/snapshots/backup_kth_es" | wc -l)
# echo "Number of snapshots: $SNAPSHOTS"
# echo "Saving all the indexes..."
# docker exec kth-invenio_es_1 curl -s -X PUT http://localhost:9200/_snapshot/backup_kth_es/snapshot_$(($SNAPSHOTS+1))?wait_for_completion=true > /dev/null 2>&1

# # saving elasticsearch dump in the host
# echo "Saving Elasticsearch data on the host in $KTH_DUMP_PATH/kth_data_dump/kth_es..."
# docker cp kth-invenio_es_1:/usr/share/elasticsearch/backup_kth_es/. $KTH_DUMP_PATH/kth_data_dump/kth_es/
