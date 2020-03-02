#!/bin/bash
#Json config file path
if [ -f /etc/redhat-release ]; then
        config="$(find / -iname snapshot.json)"
elif [ -f /etc/lsb-release ]; then
        config="$(find /home/ -iname snapshot.json)"
fi

#Passing the parameters by using json file.
bucket_name=$(jq -r '.s3_bucket.bucket_name' $config)
region=$(jq -r '.s3_bucket.region' $config)

#Copy EBS volume Snapshot to S3 bucket
#sudo snap-to-s3 --migrate --all --bucket $bucket_name
echo $config
echo $bucket_name
echo $region

