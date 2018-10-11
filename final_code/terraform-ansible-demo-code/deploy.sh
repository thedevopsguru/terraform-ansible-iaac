#!/bin/bash


# ensure SSH agent has all keys
ssh-add -A

# set up the infrastructure
cd terraform
/usr/local/bin/terraform init
/usr/local/bin/terraform plan 

cd ../ansible
# pull the instance information from Terraform, and run the Ansible playbook against it to configure
TF_STATE=../terraform/terraform.tfstate ansible-playbook "--inventory-file=$(which terraform-inventory)" provision.yml

echo "Success!"

cd ../terraform
/usr/local/bin/terraform output
