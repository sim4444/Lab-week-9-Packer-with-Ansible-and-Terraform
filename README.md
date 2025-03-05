# ACIT 4640 - Automating AWS EC2 Deployment with Packer & Terraform

## Overview

This repository facilitates the deployment of EC2 instances by leveraging Packer for AMI creation, Terraform for infrastructure provisioning, and Ansible for server configuration.

## Prerequisites

Ensure the following tools are installed on your system:

- AWS CLI

- Packer

- Terraform

- Ansible

## Additionally, create an AWS key pair:

```sh
aws ec2 create-key-pair --key-name my-key
```

## Configure AWS credentials:
```sh
aws configure
```
## Deployment Process

### Creating an AMI with Packer

Navigate to the Packer directory:
```sh
cd packer
```
Initialize Packer:
```sh
packer init .
```
Validate the configuration file:
```sh
packer validate ansible-web.pkr.hcl
```
Build the AMI:
```sh
packer build ansible-web.pkr.hcl
```
Take note of the AMI ID from the output as it will be required later.

### Launching EC2 with Terraform

Move to the Terraform directory:
```sh
cd terraform
```
Initialize Terraform:
```sh
terraform init
```
Validate the Terraform configuration:
```sh
terraform validate
```
Plan the deployment:
```sh
terraform plan
```
Deploy the infrastructure:
```sh
terraform apply -auto-approve
```
Retrieve the public IP of the EC2 instance:
```sh
terraform output instance_ip_addr
```
### Connecting to EC2 and Setting Up Nginx

Access the EC2 instance via SSH:
```sh
ssh -i /path/to/key.pem ubuntu@<EC2_PUBLIC_IP>
```
Move to the Ansible directory:
```sh
cd ansible
```
Execute the Ansible playbook:
```sh
ansible-playbook -i <EC2_PUBLIC_IP>, -u ubuntu --private-key /path/to/key.pem playbook.yml
```
Open a browser and navigate to:
```sh
http://<EC2_PUBLIC_IP>
```
We should now see the deployed web page.

### Cleaning Up Resources

To remove all deployed resources, run the following:
```sh
terraform destroy -auto-approve
```
Deregister the AMI:
```sh
aws ec2 deregister-image --image-id <AMI_ID>
```
This process ensures that all AWS resources are properly deallocated which prevents unnecessary charges.
