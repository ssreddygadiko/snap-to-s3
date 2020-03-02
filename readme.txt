1. snapshot.json:
   Fill the required variables for s3_bucket,volume,instance
   To restore the snapshot from s3 bucket fill the required variables for snapshot_in_s3 and snapshot

2. aws-config.sh : Pass the required variables to access the aws console.

3. snap-config.sh : Run this script to configure the snap-to-s3 configuration

4. bucket.sh : Run this script to create the s3 bucket

5. snap-to-s3.sh : Run this script to copy the snapshot to s3 bucket

6. s3-to-snap.sh : Run this script to copy the snapshot from s3 bucket


important points:

1. volume availability_zone must be same as instance.

2. In snapshot.json instance_id field give the same instance id where you are running all this scripts.

3. Before doing all these things please dont forgot to add the tags to all snapshot as key = snap-to-s3 value = migrate
