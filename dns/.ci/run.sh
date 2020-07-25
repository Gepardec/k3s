#!/bin/bash

set -e

ansible-lint dns/

echo 
echo "Scenario: ${1}"
echo

(cd dns && molecule lint --scenario-name ${1} )
(cd dns && molecule test --scenario-name ${1} )

set +e