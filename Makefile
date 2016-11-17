region=ap-southeast-2
stack_name=weblog
bucket=weblog-bucket-8cjakz6b6pl3

cloudformation_create:
	aws cloudformation create-stack \
	  --region ${region} \
	  --stack-name ${stack_name} \
	  --template-body file://cloudformation.yaml \
	  --capabilities CAPABILITY_IAM
	aws cloudformation wait stack-create-complete \
	  --region ${region} \
	  --stack-name ${stack_name}

cloudformation_update:
	aws cloudformation update-stack \
	  --region ${region} \
	  --stack-name ${stack_name} \
	  --template-body file://cloudformation.yaml \
	  --capabilities CAPABILITY_IAM
	aws cloudformation wait stack-update-complete \
	  --region ${region} \
	  --stack-name ${stack_name}

static/resume.pdf: resume/resume.tex
	pdflatex --output-directory resume resume/resume.tex
	mkdir -p static
	cp resume/resume.pdf static

pelican: static/resume.pdf
	pelican

s3: pelican
	aws s3 sync --cache-control max-age=86400 output s3://${bucket}

clean:
	rm -rf output
	rm -rf static
