#!/bin/bash

. /opt/chronam/ENV/bin/activate

django-admin.py check
django-admin.py migrate
django-admin.py loaddata initial_data
django-admin.py loaddata languages
django-admin.py collectstatic --noinput
