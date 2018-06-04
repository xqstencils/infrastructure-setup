#!/bin/sh

basedir="$(cd $(dirname $0) && pwd)"
rootdir="$(cd ${basedir}/../ && pwd)"

source "${basedir}/sync_files.sh"

deploy_env=$1
service_name="nginx"
target_dir="/opt/nginx"

echo "Deploy Nginx service to ${key_name} ..."; echo

echo "===================== Sync Files ==============="; echo
sync_files ${deploy_env} ${target_dir}

echo "===================== Start docker ==============="; echo
ssh ${deploy_env} "${target_dir}/init/start.sh"

echo "Deploy Nginx service done."
