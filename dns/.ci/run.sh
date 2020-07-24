#!/bin/bash

set -e

pip install -r dns/requirements.txt
ansible-lint dns/
(cd dns && molecule lint)
(cd dns && molecule test)

set +e