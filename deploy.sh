#!/bin/sh
region=ap-southeast-2
if aws --region ${region} cloudformation describe-stacks --stack-name ${JOB_NAME}; then
  action=update-stack
  wait=stack-update-complete
else
  action=create-stack
  wait=stack-create-complete
fi
aws --region ${region} cloudformation ${action} \
  --stack-name ${JOB_NAME} \
  --template-body file://cloudformation.json
aws --region ${region} cloudformation wait ${wait} \
  --stack-name ${JOB_NAME}
