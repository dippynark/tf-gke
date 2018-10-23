STATE_BUCKET_NAME := tf-state-gke-test

init:
	terraform init -backend-config=bucket=${STATE_BUCKET_NAME};

plan:
	terraform plan -out=plan.tfstate

apply:
	terraform apply plan.tfstate

destroy:
	terraform destroy