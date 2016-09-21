#!/bin/sh -e
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
  --capabilities CAPABILITY_IAM \
  --template-body file://cloudformation.yaml
aws --region ${region} cloudformation wait ${wait} \
  --stack-name ${JOB_NAME}
sudo pkg install --yes tex-formats texlive-texmf tex-dvipsk
bucket=weblog-bucket-8cjakz6b6pl3
site=`mktemp -d weblog.XXXXXX`
tmp=`mktemp -d weblog.XXXXXX`
clean () {
  rm -rf ${tmp}
  rm -rf ${site}
}
trap clean EXIT
pdflatex -output-directory ${tmp} resume/resume.tex
cp ${tmp}/resume.pdf ${site}
cp -R html/* ${site}
aws s3 sync --cache-control max-age=86400 ${site} s3://${bucket}
