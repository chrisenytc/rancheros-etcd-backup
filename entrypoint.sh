#!/bin/bash

set -e

echo "Setting environment variables"

# Set environment variables
export AWS_IAM_ROLE=$(curl "http://169.254.169.254/latest/meta-data/iam/security-credentials/" 2>/dev/null)

if [ "${AWS_IAM_ROLE}" ]; then
  export AWS_ACCESS_KEY_ID=$(curl "http://169.254.169.254/latest/meta-data/iam/security-credentials/${AWS_IAM_ROLE}" 2>/dev/null | jq -r .AccessKeyId)
  export AWS_SECRET_ACCESS_KEY=$(curl "http://169.254.169.254/latest/meta-data/iam/security-credentials/${AWS_IAM_ROLE}" 2>/dev/null | jq -r .SecretAccessKey)
  export AWS_SESSION_TOKEN=$(curl "http://169.254.169.254/latest/meta-data/iam/security-credentials/${AWS_IAM_ROLE}" 2>/dev/null | jq -r .Token)
fi

echo "Trying to upload to S3"

# Upload files
aws s3 sync /opt/src $S3_BUCKET

echo "Uploaded successfully"
echo "Done"