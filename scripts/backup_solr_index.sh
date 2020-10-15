#!/bin/bash

set -e

/usr/local/bin/aws s3 sync --only-show-errors --exact-timestamps --delete /opt/solr/solr/collection1/data/index s3://chronam-solr-backups/index
