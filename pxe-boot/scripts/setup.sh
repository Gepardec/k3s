#!/bin/bash

readonly PROGNAME=`basename "$0"`
readonly SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly TOPLEVEL_DIR=$( cd ${SCRIPT_DIR}/../.. > /dev/null && pwd )
readonly TEMPLATE_DIR=$( cd ${TOPLEVEL_DIR}/k3s/docker/config && pwd )

####################
# GLOBAL VARIABLES #
####################

FLAG_DRYRUN=false
FLAG_QUIET=false
FLAG_FORCE=false

##########
# SOURCE #
##########

for functionFile in ${TOPLEVEL_DIR}/k3s/scripts/functions/*.active;
  do source ${functionFile}
done

##########
# SCRIPT #
##########

usage_message () {
  echo """Usage:
    $PROGNAME COMMAND --resource RESOURCE [--resource RESOURCE] [OPT ..]
        //TODO: write usage message
        //TODO: getopts if needed
        """
}
readonly -f usage_message
[ "$?" -eq "0" ] || return $?

main() {
    local command=${1}
    local input=($@)
    local all_opts=(${input[@]:1})
    local extravars=""
    local namespace=""
    local print_output=false

    ## REPLACE SECRETS
    if [[ ${command} == "template" ]];then
        execute "j2-template ${TEMPLATE_DIR} config"
        exit 0
    fi

}
readonly -f main
[ "$?" -eq "0" ] || return $?

main $@