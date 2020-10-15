#!/bin/bash

set -e

cd /opt/chronam/

source /opt/chronam/ENV/bin/activate
export DJANGO_SETTINGS_MODULE=chronam.settings

for batch in $(/opt/chronam/generateBatchList.py)
do
  if [ -d "/srv/chronam/${batch}" ]
  then
    django-admin queue_load_batch /srv/chronam/batches/${batch}
  else
    echo "Batch ${batch} doesn't exist, skipping it during ingest"
  fi
done
