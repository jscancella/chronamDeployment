#!/bin/bash

set -e

cd /opt/chronam/

source /opt/chronam/ENV/bin/activate
export DJANGO_SETTINGS_MODULE=chronam.settings

#add old titles from CTS
django-admin load_titles /srv/chronam/bib/original_titles
#title_sync pulls and loads titles from worldcat
django-admin title_sync > /dev/null
django-admin load_essays > /dev/null
django-admin load_holdings > /dev/null

#TODO load all the batches or just some for testing?
django-admin.py load_batch /srv/chronam/batches/batch_uuml_thys_ver01 > /dev/null

