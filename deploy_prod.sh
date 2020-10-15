#!/bin/bash

ansible-playbook deploy.yml --extra-vars="env=Production" --inventory=production.aws_ec2.yml "$@"
