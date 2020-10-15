#!/usr/local/bin/python
# assumes python2

import requests
from operator import itemgetter
from collections import defaultdict

batches_awardee = defaultdict(list)

def append_batches(request):
    for batch in request.json()['batches']:
        awardee = batch['name'].split("_")[1]
        batches_awardee[awardee].append((batch['name'], batch['ingested']))

def get_batches(page):
    r = requests.get(page)
    append_batches(r)
    if "next" in r.json():
        print("getting next page of batches")
        get_batches(r.json()['next'])   

get_batches("http://chroniclingamerica.loc.gov/batches.json")

for awardee, batches_by_date in batches_awardee.iteritems():
    with open('batch_ingest_order/%s_ingest_order.txt' % awardee, 'w') as f:
        print("writing out batch ingest order for %s" % awardee)
        batches_by_date = sorted(batches_by_date, key=itemgetter(1))
        for batch in batches_by_date:
            f.write(batch[0][6:])
            f.write("\n")
