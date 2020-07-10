#!/bin/bash

readonly PROGNAME=`basename "$0"`
readonly SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly TOPLEVEL_DIR=$( cd ${SCRIPT_DIR}/../.. > /dev/null && pwd )
readonly TEMPLATE_DIR=$( cd ${TOPLEVEL_DIR}/k3s/docker/config && pwd )

readonly COMMANDS=( "template"
#                    "install"
#                    "upgrade"
#                    "uninstall"
#                    "replace-secrets"
#                    "help"
                  )

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

    if [[ ! " ${COMMANDS[@]} " =~ " ${command} " ]] || [[ ${command} == "help" ]]; then
       usage_message
       exit 0
    fi

     # getopts
    local opts=`getopt -o fqdr:e:w --long force,dryrun,quiet,resource:,ns-hogarama:,ns-keycloak,write-template: -- "${all_opts[@]}"`
    local opts_return=$?
    if [[ ${opts_return} != 0 ]]; then
        echo
        (>&2 echo "failed to fetch options via getopt")
        echo
        return ${opts_return}
    fi
    eval set -- "$opts"
    while true ; do
        case "$1" in
#        --resource | -r)
#            resources+=${2,,}
#            shift 2
#            ;;
        -d | --dryrun)
            FLAG_DRYRUN=true
            shift 1
            ;;
        -q | --quiet)
            FLAG_QUIET=true
            shift 1
            ;;
        -f | --force)
            FLAG_FORCE=true
            shift 1
            ;;
#        -e )
#            extravars="${extravars} -e ${2}"
#            shift 2
#            ;;
#        --ns-hogarama)
#            namespace_hogarama="${2,,}"
#            shift 2
#            ;;
#        --ns-keycloak)
#            namespace_keycloak="${2,,}"
#            shift 2
#            ;;
#        --write-template | -w)
#            print_output=true
#            shift 1
#            ;;
        *)
          break
          ;;
        esac
    done

    ## TEMPLATE
    if [[ ${command} == "template" ]];then
        execute "j2-template ${TEMPLATE_DIR} config"
        exit 0
    fi

}
readonly -f main
[ "$?" -eq "0" ] || return $?

main $@