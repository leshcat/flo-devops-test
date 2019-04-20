#!/bin/bash

sudo yum install docker amazon-efs-utils httpd -y

sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose;
sudo chmod +x /usr/local/bin/docker-compose

sudo systemctl start httpd

hostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)

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

exit_code=$?

case $exit_code in

  "0")
    lifecycle_action_result="CONTINUE"
    ;;
  *)
    lifecycle_action_result="ABANDON"
    ;;
esac

aws autoscaling complete-lifecycle-action \
                --lifecycle-action-result $lifecycle_action_result \
                --instance-id $instance_id \
                --lifecycle-hook-name ${autoscaling_lifecycle_hook_name} \
                --auto-scaling-group-name ${autoscaling_group_name} \
                --region ${region}
