#!/bin/bash

sudo yum install docker amazon-efs-utils httpd -y

sudo systemctl enable httpd
sudo systemctl start httpd

hostname=$(curl 169.254.169.254/latest/meta-data/public-hostname)

cat >/var/www/html/index.html <<EOF
This is instance: $hostname
EOF

sudo systemctl start docker
sudo systemctl enable docker

# Enable cadvisor
sudo docker run \
       --volume=/:/rootfs:ro \
       --volume=/var/run:/var/run:rw \
       --volume=/sys:/sys:ro \
       --volume=/var/lib/docker/:/var/lib/docker:ro \
       --volume=/dev/disk/:/dev/disk:ro \
       --publish=8080:8080 \
       --detach=true \
      --name=cadvisor \
      google/cadvisor:latest

sudo mkdir -p /mnt/efs

sudo mount -t efs ${efs_id}:/ /mnt/efs
