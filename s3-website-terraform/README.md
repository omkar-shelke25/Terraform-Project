# S3 Website Hosting with Terraform

This project automates the deployment of an S3 bucket configured for static website hosting using Terraform.

## Project Structure

- **`acl.tf`**: Contains Access Control List (ACL) configurations for the S3 bucket.
- **`provider.tf`**: Defines the Terraform provider configurations, including AWS credentials and region.
- **`terraform.tfstate`**: The state file that tracks the current state of the deployed infrastructure.
- **`terraform.tfvars`**: Variables file containing values for Terraform variables, such as AWS credentials or S3 bucket configurations.
- **`versioning.tf`**: Configures versioning for the S3 bucket to keep track of object versions.
- **`website_hosting.tf`**: Contains the configuration for enabling static website hosting on the S3 bucket.
- **`main.tf`**: The main Terraform configuration file that ties together all resources for the S3 website deployment.
- **`policy.tf`**: Defines IAM policies for S3 bucket access.
- **`README.md`**: This file, providing an overview of the project and how to use it.
- **`terraform.tfstate.backup`**: A backup of the state file.
- **`variables.tf`**: Defines the variables used throughout the Terraform configuration.
- **`website/`**: A directory containing the website files (HTML, CSS, JavaScript) to be uploaded to the S3 bucket.

## Prerequisites

- Terraform installed on your machine.
- AWS account and credentials configured on your local machine.
- AWS CLI installed and configured (optional but recommended).

## Setup Instructions

1. Clone the repository:

   ```bash
   git clone https://github.com/your-repo/s3-website-terraform.git
   cd s3-website-terraform
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Review and modify the `terraform.tfvars` file to include your desired values, such as the AWS region and S3 bucket name.

4. Apply the Terraform configuration to create the S3 bucket and deploy the website:

   ```bash
   terraform apply
   ```

   Terraform will prompt for confirmation. Type `yes` to proceed.

5. After the deployment is complete, you can access your static website through the S3 bucket's website endpoint.

## Project Overview

This Terraform project sets up an S3 bucket with the necessary configuration to host a static website. It automates the following tasks:

- Creates an S3 bucket with the specified name.
- Configures the S3 bucket for static website hosting.
- Sets up versioning for the S3 bucket to keep track of object versions.
- Sets up the appropriate IAM policies and ACLs for accessing the S3 bucket.
- Uploads website files from the `website/` directory to the S3 bucket.

## Clean Up

To destroy the resources created by this Terraform configuration, run:

```bash
terraform destroy
```

Confirm the destruction by typing `yes`.

## Notes

- Ensure that your AWS credentials are set up correctly to avoid any authentication issues.
- You can modify the S3 bucket's settings, such as adding a custom domain or enabling logging, by updating the Terraform configuration files.

---
