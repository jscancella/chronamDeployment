#!/bin/bash

ansible-playbook deploy.yml --extra-vars "env=Staging" --inventory=stage.aws_ec2.yml "$@"
