#!/bin/sh -e
sudo pkg install --yes tex-formats texlive-full
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
