#!/bin/bash

set -e

pip install -r requirements.txt
ansible-playbook dns/tests/test.yml -i dns/tests/inventory --syntax-check
ansible-lint dns/
(cd dns && molecule lint)
(cd dns && molecule test)

set +e