#!/bin/bash

bash ./scripts/k3s-rebuild.sh
bash ./scripts/ansible-inventory.sh

ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook.yml
