#!/bin/bash

# export .env variables
export $(grep -v '^#' ../.env | xargs)


# copy latest dump to the container
echo "Copying metadata in ${POSTGRES_CONTAINER} ..."
latest_backup=$(printf '%s\n' $KTH_DUMP_PATH/kth_data_dump/kth_db/* | sort -rn | head -n1)
FILENAME=${latest_backup##*/}
docker exec $POSTGRES_CONTAINER mkdir -p backup_kth_db
docker cp $latest_backup $POSTGRES_CONTAINER:/backup_kth_db/
echo "Restoring db postgress metadata..."
docker exec $POSTGRES_CONTAINER psql -f /backup_kth_db/$FILENAME -U $PG_USER > /dev/null 2>&1