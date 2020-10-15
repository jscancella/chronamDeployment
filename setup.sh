#!/bin/bash

ansible-playbook setup.yml --extra-vars "env=dev"
ansible-playbook setup.yml --extra-vars "env=test"
ansible-playbook setup.yml --extra-vars "env=stage"
ansible-playbook setup.yml --extra-vars "env=prod"
