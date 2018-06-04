#!/bin/sh

basedir="$(cd $(dirname $0) && pwd)"
rootdir="$(cd ${basedir}/../ && pwd)"

source "${basedir}/sync_files.sh"

deploy_env=$1
target_dir="/opt/infrastructure"

echo "Deploy Infrastructure services to ${key_name} ..."; echo

echo "===================== Sync Files ==============="; echo
sync_files ${deploy_env} ${target_dir}

echo "===================== Start docker ==============="; echo
ssh ${deploy_env} "${target_dir}/start.sh"

echo "Deploy Infrastructure services done."
