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

#create s3 bucket
aws s3api create-bucket --bucket $bucket_name --region $region --create-bucket-configuration LocationConstraint=$region

