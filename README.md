# AWS + Terraform End-to-End Project
Example of using Terraform to provision AWS infrastructure for a simple website:
* Network configuration 
* Route 53 DNS configuration
* Elastic Load Balancer
* Multiple EC2 instances
* S3 storage

## Configuration Files
All Terraform configuration files are located in the `infrastructure` folder:
* main.tf: Contains the provider configuration
* variables.tf: Defines the input variables
* outputs.tf: Defines the output variables
* network.tf: Contains network-related resources like VPC, subnets, and route tables
* instances.tf: Contains the EC2 instance configurations
* load_balancer.tf: Configures the Elastic Load Balancer and target groups
* s3.tf: Configures the S3 bucket and policies
* dns.tf: Configures Route 53 DNS settings

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
* After you are done, de-provision the infrastructure:
```
terraform destroy
```
