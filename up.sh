#!/bin/bash

bash scripts/k3s-rebuild.sh
bash scripts/inventory.sh

ansible-playbook -i ansible/inventory.yaml ansible/site.yaml
