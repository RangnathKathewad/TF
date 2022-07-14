Steps:-

1. SSH to Terraform VM - 
gcloud compute ssh terraform-iac-instance --region us-central1

2. Execute following terraform commands to create instance template

terraform init

***for staging

terraform plan -var-file=dev.tfvars -lock=false -out tf-plan

***for med-and-beyoynd

terraform plan -var-file=antidote-prod.tfvars -lock=false -out tf-plan


terraform apply -lock=false -auto-approve tf-plan 


3. Execute following terraform command to delete the resources

***for staging

terraform destroy -var-file=dev.tfvars -lock=false -auto-approve

***for med-and-beyoynd

terraform destroy -var-file=antidote-prod.tfvars -lock=false -auto-approve
