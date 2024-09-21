#!/bin/sh
echo "Setting Minio..."
mcli alias set minio $MINIO_HOST $MINIO_KEY $MINIO_SECRET
echo "DONE Setting Minio"

echo "Setting pgpass..."
echo $PG_HOST:$PG_PORT:$PG_DB:$PG_USERNAME:$PG_PASSWORD > ~/.pgpass
chmod 600 ~/.pgpass
echo "DONE Setting pgpass"

echo "Dumping Database..."
time pg_dump --host=$PG_HOST --port=$PG_PORT --format=custom --no-acl --no-owner --username=$PG_USERNAME --file="strapi_db_backup_$(date +%s)" $PG_DB
echo "DONE Dumping Database"

echo "Uploading to minio..."
mcli cp strapi* minio/${MINIO_BUCKET}
echo "DONE Uploading to minio"

echo "Remove uploaded file"
rm strapi*
echo "DONE uploaded file"
