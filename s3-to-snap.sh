#!/bin/bash
#Json config file path
if [ -f /etc/redhat-release ]; then
        config="$(find / -iname snapshot.json)"
elif [ -f /etc/lsb-release ]; then
        config="$(find /home/ -iname snapshot.json)"
fi

#Passing the parameters by using json file.
volume_type=$(jq -r '.volume.volume_type' $config)
volume_size=$(jq -r '.volume.volume_size' $config)
availability_zone=$(jq -r '.volume.availability_zone' $config)
instance_id=$(jq -r '.instance.instance_id' $config) 
device=$(jq -r '.instance.device' $config)
directory=$(jq -r '.instance.directory' $config)
snapshot_path=$(jq -r '.snapshot_in_s3.snapshot_path' $config)
description=$(jq -r '.snapshot.description' $config)

#Creating EBS Volume
volume_id=`aws ec2 create-volume --volume-type $volume_type --size $volume_size --availability-zone $availability_zone |grep VolumeId |sed 's/.$//' |awk '{gsub("\"",""); print $2}'`
aws ec2 wait volume-available --volume-ids $volume_id

#Attaching new EBS volume to instance.
aws ec2 attach-volume --volume-id $volume_id --instance-id $instance_id --device $device
aws ec2 wait volume-in-use --volume-ids $volume_id
sleep 5

#Mount the volume to this instance
sudo mkdir -p $directory
sudo file -s $device
sudo mkfs -t xfs $device
sudo mount $device $directory

#copy snapshot s3 bucket to ebs volume
cd $directory
aws s3 cp "$snapshot_path" - | lz4 -d | sudo tar -x

#Take the snapshot of EBS volume
snapshot_id=`aws ec2 create-snapshot --volume-id $volume_id --description "$description" |grep SnapshotId |sed 's/.$//' |awk '{gsub("\"",""); print $2}'`
aws ec2 wait snapshot-completed --snapshot-ids $snapshot_id


#umount the volume
sudo umount -l $device

#detach the volume
aws ec2 detach-volume --volume-id $volume_id
aws ec2 wait volume-available --volume-ids $volume_id



#Delete the volume
aws ec2 delete-volume --volume-id $volume_id
rm -rf $directory
