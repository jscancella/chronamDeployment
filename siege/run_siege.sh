#!/usr/local/bin/bash

#siege -c 200 -f chronam-loadbalancer-urls.txt
#siege -c 100 -f chronam-ec2-urls.txt
siege -c 50 -f chronam-ec2-search-only-urls.txt
