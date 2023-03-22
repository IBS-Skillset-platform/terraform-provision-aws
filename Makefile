
.PHONY: login-aws
login-aws-ibs:
	aws configure import --csv credentials.csv

.PHONY: init-aws-eks
init-aws-eks: login-aws-ibs
	cd eks-cluster && terraform init

.PHONY: plan-aws-eks
plan-aws-eks: init-aws-ibs
	cd eks-cluster && terraform plan

.PHONY: apply-aws-eks
apply-aws-eks: plan-aws-ibs
	cd eks-cluster && terraform apply

