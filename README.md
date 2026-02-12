
# Production-Ready Multi-Tier AWS Infrastructure Project
## Project Overview
This project demonstrates the **design, deployment, and management of a production-ready multi-tier AWS infrastructure** using **Terraform** for provisioning and **Ansible** for configuration management. The project implements a real-world cloud architecture scenario, suitable for learning and showcasing DevOps and Cloud skills.

**Project Goals:**
- Provision scalable and secure AWS infrastructure from scratch.
- Implement multi-tier architecture: **Web Tier → Application Tier → Database Tier**.
- Use **Terraform** for Infrastructure as Code (IaC) and **Ansible** for configuration management.
- Manage Terraform state remotely using **S3 + DynamoDB**.
- Ensure **high availability** and **security best practices**.
- Prepare a complete, reusable infrastructure project for portfolio or resume.

---

## Technologies & Tools Used

| Layer / Service       | Tool / Service              |
|-----------------------|----------------------------|
| Infrastructure as Code| Terraform                  |
| Configuration Mgmt    | Ansible                    |
| Cloud Platform        | AWS                        |
| Web Tier              | EC2, Auto Scaling Groups   |
| App Tier              | EC2, Auto Scaling Groups   |
| Database Tier         | RDS MySQL (Multi-AZ)      |
| Networking            | VPC, Subnets, IGW, NAT, Route Tables |
| State Management      | S3 + DynamoDB (Terraform backend) |
| Security              | Security Groups, Key Pair  |

---

## Project Structure

```

terraform-aws-production-infra/
├── README.md
├── app-ec2.tf                  # Application tier EC2 configuration
├── backend.tf                  # Terraform backend configuration (S3 + DynamoDB)
├── backend_resources.tf        # Terraform resources for backend (S3, DynamoDB)
├── hosts.ini                   # Ansible inventory file
├── nat.tf                      # NAT Gateway configuration
├── rds.tf                      # RDS MySQL configuration
├── security-groups.tf          # Security Groups for Web, App, DB tiers
├── terraform.tfstate           # Terraform state file
├── terraform.tfstate.backup    # Terraform state backup
├── vpc.tf                      # VPC, Subnets, Internet Gateway, Route tables
└── web-asg.tf                  # Web tier Launch Template & Auto Scaling Group

````

---

## Key Features Implemented
1. **Multi-Tier Architecture**
   - Web tier: Nginx on EC2 instances with Auto Scaling.
   - Application tier: EC2 instances (optional playbooks can be added).
   - Database tier: MySQL RDS with Multi-AZ for high availability.
2. **Networking**
   - Custom VPC with public and private subnets.
   - Internet Gateway and NAT Gateway for secure private subnet access.
   - Route tables and associations for proper routing.
3. **Security**
   - Security Groups for Web, App, and DB tiers.
   - IAM permissions for Terraform automation.
   - EC2 key pair used for SSH access.
4. **State Management**
   - Terraform backend stored in **S3** with **DynamoDB** for state locking.
5. **High Availability & Scalability**
   - Auto Scaling Groups for web tier EC2s.
   - Multi-AZ deployment for RDS MySQL.

---

## Execution Summary

**Prerequisites:**
- Ubuntu 24.04 server
- Terraform installed
- Ansible installed
- AWS CLI configured
- EC2 key pair (`.pem` file) for SSH

**Execution Steps:**
1. Initialize Terraform:
```bash
terraform init
````

2. Validate configuration:

```bash
terraform validate
```

3. Plan Terraform deployment:

```bash
terraform plan
```

4. Apply Terraform deployment:

```bash
terraform apply
# Type 'yes' when prompted
```

5. Configure EC2 instances with Ansible:

```bash
ansible all -i hosts.ini -m ping
ansible-playbook -i hosts.ini setup-web.yml
```

6. Capture **screenshots**:

   * Terraform plan/apply outputs
   * AWS Console for EC2, RDS, VPC, S3, DynamoDB

---

## Cleanup / Deletion

1. Destroy all Terraform-managed resources:

```bash
terraform destroy -auto-approve
```

2. Check AWS Console:

   * Terminate remaining EC2 instances
   * Delete RDS instances
   * Delete VPC, subnets, IGW, NAT Gateway, and route tables
3. Optional: Remove local Terraform files:

```bash
rm -rf terraform.tfstate terraform.tfstate.backup .terraform/
```

---

## Project Outcome / Skills Gained

* Hands-on experience with **Terraform + Ansible + AWS** for multi-tier deployments.
* Implemented **scalable, secure, and highly available infrastructure**.
* Gained understanding of **remote state management, Auto Scaling, Multi-AZ RDS, VPC design**.
* Portfolio-ready project to showcase **DevOps and Cloud Engineering skills**.

## Project Guide
This project was created under the guidance of **Shubham Londhe**.


