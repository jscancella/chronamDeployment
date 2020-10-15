#!/bin/bash

ansible-playbook deploy.yml --extra-vars "env=Testing" --inventory=test.aws_ec2.yml "$@"
