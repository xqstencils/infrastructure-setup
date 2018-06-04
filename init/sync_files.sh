#!/bin/sh

basedir="$(cd $(dirname $0) && pwd)"
rootdir="$(cd ${basedir}/../ && pwd)"

archive_file_name="deploy_package.tar.gz"

archive_files()
{
  echo "Archive files into ${archive_file_name} ..."
  rm -rf "${rootdir}/${archive_file_name}"
  tar czf "${rootdir}/${archive_file_name}" auth certs config data init/start.sh
  echo "Archive files done"
}

sync_files_to_remote()
{
  local env_key_name=$1
  echo "Sync files to ${env_key_name} ..."
  scp "${rootdir}/${archive_file_name}" ${env_key_name}:/tmp/
  echo "Sync files done"
}

unarchive_files_in_remote()
{
  local env_key_name=$1
  local target_dir=$2
  echo "Remove target dir ${target_dir} in remote."
  ssh ${env_key_name} rm -rf ${target_dir}
  echo "Create target dir ${target_dir} in remote."
  ssh ${env_key_name} mkdir -p ${target_dir}
  echo "Unarchive files to ${target_dir} in remote ..."
  ssh ${env_key_name} tar xzf "/tmp/${archive_file_name}" -C ${target_dir}
  echo "Archive files done"
}

remove_archive_files()
{
  local env_key_name=$1
  echo "Remove remote archive files"
  ssh ${env_key_name} rm -rf "/tmp/${archive_file_name}"
  echo "Remove local archive files"
  rm -rf "${rootdir}/${archive_file_name}"
  echo "remove archive files done"
}

sync_files()
{
  local env_key_name=$1
  local target_dir=$2
  archive_files
  sync_files_to_remote ${env_key_name}
  unarchive_files_in_remote ${env_key_name} ${target_dir}
  remove_archive_files ${env_key_name}
}
