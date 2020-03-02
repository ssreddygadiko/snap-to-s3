#configure snap-to-s3
if [ -f /etc/redhat-release ]; then
curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
sudo yum install -y nodejs
sudo yum install git
sudo npm install -g snap-to-s3	

#Install jq json processor
sudo yum install epel-release -y
sudo yum install jq -y

elif [ -f /etc/lsb-release ]; then
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install liblz4-tool
sudo npm install -g snap-to-s3

#Install jq json processor
sudo apt-get install jq -y
fi
