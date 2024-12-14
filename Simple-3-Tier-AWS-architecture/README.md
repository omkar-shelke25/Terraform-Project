```markdown
# AWS VPC Terraform Configuration - 3-Tier Architecture

This repository contains a **Terraform configuration** for creating a **3-Tier VPC architecture** in AWS. The architecture includes Public, Private, and Database subnets, with associated routing and gateway configurations. The setup is designed for a scalable, secure, and highly available application infrastructure.

## Architecture Overview

The Terraform script defines the following AWS resources:

1. **VPC (Virtual Private Cloud)**:
   - A private isolated network in AWS with a CIDR block of `10.0.0.0/16`.

2. **Subnets**:
   - **Public Subnets**: For resources that need direct access to the internet (e.g., web servers). CIDR blocks: `10.0.1.0/24`, `10.0.2.0/24`.
   - **Private Subnets**: For resources that do not need direct internet access (e.g., application servers). CIDR blocks: `10.0.21.0/24`, `10.0.22.0/24`.
   - **Database Subnets**: For database resources that require isolation from the internet. CIDR blocks: `10.0.51.0/24`, `10.0.52.0/24`.

3. **Gateways**:
   - **Internet Gateway (IGW)**: Provides internet access for resources in the public subnets.
   - **NAT Gateway**: Allows outbound internet access for resources in private subnets.

4. **Route Tables**:
   - Public subnets route traffic to the Internet Gateway.
   - Private subnets route traffic to the NAT Gateway for secure internet access.
   - Database subnets have no internet routes to ensure isolation.

## Architecture Diagram

Below is a simplified representation of the architecture:

```plaintext
+------------------------------------------------------------+
|                     AWS Virtual Private Cloud (VPC)        |
|                          CIDR: 10.0.0.0/16                |
+------------------------------------------------------------+
                                |
        +-----------------------+-----------------------+
        |                       |                       |
+-------v-------+       +-------v-------+       +-------v-------+
| Public Subnet |       | Private Subnet|       | Database Subnet|
| CIDR: 10.0.1.0/24 |   | CIDR: 10.0.21.0/24 | | CIDR: 10.0.51.0/24|
| CIDR: 10.0.2.0/24 |   | CIDR: 10.0.22.0/24 | | CIDR: 10.0.52.0/24|
+-------------------+       +-------------------+       +-------------------+
        |                       |                       |
   +----v----+             +----v----+            +----v----+
   | IGW     |             | NAT GW  |            | No IGW  |
   | Internet|             | Network |            | Isolated|
   | Gateway |             | Gateway |            |         |
   +---------+             +---------+            +---------+

Route Tables:
  - Public Subnet Route Table:
    Destination: 0.0.0.0/0 → Internet Gateway (IGW)

  - Private Subnet Route Table:
    Destination: 0.0.0.0/0 → NAT Gateway

  - Database Subnet Route Table:
    No routes to the internet
```

## Features

- **VPC Creation**: Creates a VPC with a CIDR block of `10.0.0.0/16`.
- **Public, Private, and Database Subnets**: Automatically creates subnets with defined CIDR blocks.
- **Internet Gateway (IGW)**: Automatically creates an Internet Gateway for public subnets.
- **NAT Gateway**: Enables secure outbound internet access for private subnets.
- **Route Tables**: Automatically creates route tables and associates them with the correct subnets:
  - Public subnets route to IGW.
  - Private subnets route to NAT Gateway.
  - Database subnets are isolated with no internet routes.

## Prerequisites

- **Terraform**: Ensure you have Terraform installed. You can download it from [Terraform's official website](https://www.terraform.io/downloads).
- **AWS Account**: You need an AWS account and the necessary permissions to create VPC, subnets, gateways, and route tables.
- **AWS CLI**: Ensure that the AWS CLI is configured with your AWS credentials. You can set up the AWS CLI by following the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/aws-vpc-terraform.git
   cd aws-vpc-terraform
   ```

2. **Initialize Terraform**:
   Initialize the Terraform configuration to download the necessary providers and modules:
   ```bash
   terraform init
   ```

3. **Plan the Deployment**:
   Run the following command to preview the changes Terraform will make:
   ```bash
   terraform plan
   ```

4. **Apply the Configuration**:
   Apply the Terraform configuration to create the VPC and its resources:
   ```bash
   terraform apply
   ```

5. **Verify the Deployment**:
   After the deployment is complete, you can verify the resources in the AWS Management Console under the **VPC** section.

## Outputs

After the successful creation of the VPC, Terraform will output the following information:

- VPC ID
- Public Subnet IDs
- Private Subnet IDs
- Database Subnet IDs
- NAT Gateway ID
- Internet Gateway ID

## Clean Up

To remove the created resources, run the following command:
```bash
terraform destroy
```

This will delete all the resources created by Terraform in your AWS account.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```

