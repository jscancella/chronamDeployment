#!/bin/bash

ansible-playbook deploy.yml --extra-vars "env=Development" --inventory=dev.aws_ec2.yml "$@"
