
### **1. Module Declaration**
```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
```
- **What is a module?**
  A module is a reusable piece of Terraform code. It simplifies configuration by providing pre-built functionality.

- **Source**: The `source` specifies where to fetch the module. Here, it uses the official AWS VPC module from the Terraform Registry.

---

### **2. VPC Configuration**
```hcl
name = "simple-3-tier-vpc"
cidr = "10.0.0.0/16"
```

- **VPC Name**: This is the name of the VPC for identification purposes.

- **CIDR Block**:  
  - CIDR (`10.0.0.0/16`) defines the range of IP addresses available in the VPC.
  - `/16` means the VPC can contain **65,536 IP addresses** (from `10.0.0.0` to `10.0.255.255`).

---

### **3. Subnets**
Subnets divide the VPC into smaller networks. Subnets can be **public**, **private**, or **isolated** based on their purpose.

#### **Public Subnets**
```hcl
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
```
- Public subnets are used for resources that need **direct internet access** (e.g., web servers).
- Each subnet has 256 IP addresses (from `10.0.1.0` to `10.0.1.255` for the first subnet).

#### **Private Subnets**
```hcl
private_subnets = ["10.0.21.0/24", "10.0.22.0/24"]
```
- Private subnets host resources that **should not be directly accessible from the internet**, such as application servers or internal services.
- Outbound internet access for private subnets is provided through a **NAT Gateway**.

#### **Database Subnets**
```hcl
database_subnets = ["10.0.51.0/24", "10.0.52.0/24"]
create_database_subnet_group = true
create_database_subnet_route_table = true
```
- Database subnets are **isolated** for security and are intended for database services like Amazon RDS.
- **Subnet Group**: A logical grouping of subnets for database resources.
- **Route Table**: A dedicated route table ensures no direct internet access for these subnets.

---

### **4. Availability Zones**
```hcl
azs = ["ap-south-1a", "ap-south-1b"]
```
- **What are AZs?**
  Availability Zones are distinct data centers within a region (e.g., `ap-south-1` is the Mumbai region).
- **Why specify AZs?**
  Subnets are distributed across multiple AZs to improve **fault tolerance** and **high availability**.

---

### **5. NAT Gateway**
```hcl
enable_nat_gateway = true
one_nat_gateway_per_az = true
```
- **What is a NAT Gateway?**
  A NAT Gateway allows instances in private subnets to access the internet for updates, downloads, etc., without exposing them to incoming internet traffic.

- **one_nat_gateway_per_az**: Creates a NAT Gateway in each AZ for redundancy.

---

### **6. Internet Gateway**
- **What is an Internet Gateway (IGW)?**
  An IGW allows resources in **public subnets** to communicate directly with the internet.

- **Automatic Creation**: In this module, the IGW is automatically created because public subnets are defined.

---

### **7. Route Tables**
Route tables determine how network traffic is directed.

#### Public Subnets
- Automatically associated with a **route table** that includes a route:
  ```
  0.0.0.0/0 → Internet Gateway
  ```
  This means all outbound traffic (0.0.0.0/0) is routed through the Internet Gateway.

#### Private Subnets
- Associated with a route table that includes:
  ```
  0.0.0.0/0 → NAT Gateway
  ```
  This allows outbound internet access via the NAT Gateway.

#### Database Subnets
- Associated with a **dedicated route table** that does **not include internet routes**. These subnets are completely isolated for security.

---

### **8. Tags**
```hcl
tags = {
  Terraform   = "true"
  Environment = "dev"
}
```
Tags help with resource identification and organization. For example:
- **Terraform = true**: Indicates the resource is managed by Terraform.
- **Environment = dev**: Indicates the environment (e.g., dev, staging, or prod).

---

### **9. Visual Representation**
Here’s a simplified diagram of how the subnets, route tables, and gateways are configured:

| **Subnet Type** | **Route Table**           | **Route**                     | **Subnet Association** | **Internet Access**       |
|------------------|---------------------------|--------------------------------|-------------------------|---------------------------|
| Public Subnets   | Automatically created     | `0.0.0.0/0 → Internet Gateway`| Public subnets         | Direct internet access    |
| Private Subnets  | Automatically created     | `0.0.0.0/0 → NAT Gateway`     | Private subnets        | Outbound internet access  |
| Database Subnets | Dedicated route table     | No internet routes            | Database subnets       | No internet access        |

---

### **Summary**
This Terraform code creates:
1. A **3-tier VPC** with public, private, and database subnets distributed across two AZs.
2. **Public subnets** for internet-facing resources.
3. **Private subnets** for backend services with NAT Gateway for internet access.
4. **Database subnets** isolated from the internet.
5. Automatic creation of Internet Gateway, NAT Gateway, and route tables.

This architecture is a standard design for securely hosting applications in AWS.