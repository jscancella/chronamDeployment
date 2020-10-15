#!/usr/local/bin/python

import requests
from operator import itemgetter

batches_by_date = list()

def append_batches(request):
    for batch in request.json()['batches']:
        batches_by_date.append((batch['name'], batch['ingested']))

has_next_page = True

page = "http://chroniclingamerica.loc.gov/batches.json"

while has_next_page:
#    print("Getting page %s" % page)
    r = requests.get(page)
    if "next" not in r.json():
        has_next_page = False
    else:
        page = r.json()['next']
    append_batches(r)

batches_by_date = sorted(batches_by_date, key=itemgetter(1))

for batch in batches_by_date:
    print(batch[0])
