#!/bin/bash
#variables to configure aws-cli
echo "Enter the user access key to access the aws console:"
read access_key
echo "Enter the user secret key to access the aws console:"
read secret_key
echo "Enter the default region to access the aws console:"
read region
echo "Enter output format:"
read output_format

#aws configure
if [ -f /etc/redhat-release ]; then
sudo yum update
sudo yum install awscli -y

elif [ -f /etc/lsb-release ]; then
sudo ap-get update
sudo apt install awscli -y
fi

#Set aws configuration
aws configure set aws_access_key_id $access_key 
aws configure set aws_secret_access_key $secret_key 
aws configure set default.region $region 
aws configure set output_format $output_format
