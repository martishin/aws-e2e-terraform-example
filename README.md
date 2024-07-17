# AWS + Terraform full-stack end-to-end project
Example of using Terraform to provision AWS infrastructure for a simple website:
* Network configuration 
* Route 53 DNS configuration
* Elastic Load Balancer
* Multiple EC2 instances
* S3 storage

## Setup
* Navigate to the `infrastructure` directory
```
cd infrastructure
```
* Create a `terraform.tfvars` file to provide your AWS credentials:
```
echo 'aws_access_key = "{YOUR_ACCESS_KEY}"' >> terraform.tfvars
echo 'aws_secret_key = "{YOUR_SECRET_KEY}"' >> terraform.tfvars
```
Replace {YOUR_ACCESS_KEY} and {YOUR_SECRET_KEY} with your actual AWS access key and secret key

## Usage
* Initialize Terraform:
```
terraform init
```
* Apply the Terraform configuration to provision the infrastructure:
```
terraform apply
```
* Once the process is finished, the address of the load balancer will be shown in the output under `load_balancer_dns`.
