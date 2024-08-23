#!/bin/bash
host="172.32.140.150"
backup_dir="backup/$(date '+%Y-%m-%d_%H:%M:%S')"

mkdir -p "$backup_dir"
mkdir -p "$backup_dir/npm/data"
mkdir -p "$backup_dir/npm/letsencrypt"
mkdir -p "$backup_dir/portainer/portainer-data"
mkdir -p "$backup_dir/nextcloud/nextcloud_db"
mkdir -p "$backup_dir/nextcloud/nextcloud_nextcloud"
mkdir -p "$backup_dir/onlyoffice/onlyoffice_postgresql_data"

rsync -avz -e "ssh -p 22" --progress $host:/home/docker/docker/nginxproxymanager/data/* $backup_dir/npm/data
rsync -avz -e "ssh -p 22" --progress $host:/home/docker/docker/nginxproxymanager/letsencrypt/* $backup_dir/npm/letsencrypt
rsync -avz -e "ssh -p 22" --progress $host:/home/docker/docker/portainer/portainer-data/* $backup_dir/portainer/portainer-data
rsync -avz -e "ssh -p 22" --progress $host:/var/lib/docker/volumes/nextcloud_db/* $backup_dir/nextcloud/nextcloud_db
rsync -avz -e "ssh -p 22" --progress $host:/var/lib/docker/volumes/nextcloud_nextcloud/* $backup_dir/nextcloud/nextcloud_nextcloud
rsync -avz -e "ssh -p 22" --progress $host:/var/lib/docker/volumes/onlyoffice_postgresql_data/* $backup_dir/onlyoffice/onlyoffice_postgresql_data

tar -czf "$backup_dir".tar $backup_dir

rm -rf $backup_dir