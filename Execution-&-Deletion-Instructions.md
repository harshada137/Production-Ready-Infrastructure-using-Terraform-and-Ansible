
---

### **Execution_And_Deletion.md**

````markdown
# Execution & Deletion Instructions
**Project Guide:** Shubham Londhe

This document provides step-by-step instructions to **execute, manage, and delete** the production-ready AWS multi-tier infrastructure project.

---

## Prerequisites

1. Ubuntu 24.04 server
2. Terraform installed (v1.6.x recommended)
3. Ansible installed
4. AWS CLI configured with proper credentials
5. EC2 key pair (`aws-eks.pem`) available for SSH access
6. Internet connectivity

---

## 1. Terraform Execution Steps

### Step 1: Navigate to Project Directory
```bash
cd ~/terraform-aws-production-infra
````

### Step 2: Initialize Terraform

```bash
terraform init
```

* Sets up backend (S3 + DynamoDB)
* Downloads required providers

### Step 3: Validate Terraform Configuration

```bash
terraform validate
```

* Checks for syntax errors and unsupported arguments

### Step 4: Plan Terraform Deployment

```bash
terraform plan
```

* Generates execution plan
* Review resources to be created

### Step 5: Apply Terraform Deployment

```bash
terraform apply
```

* Type `yes` when prompted
* Wait for Terraform to provision:

  * VPC, Subnets, IGW, NAT
  * EC2 instances for Web & App tiers
  * RDS MySQL database
  * Security Groups, Route Tables

### Step 6: Take Screenshots

* Terraform apply outputs
* AWS Console:

  * EC2 instances
  * RDS instance
  * VPC/Subnets
  * S3 bucket & DynamoDB table

---

## 2. Ansible Configuration Steps

### Step 1: Update Inventory

```ini
# hosts.ini
[web]
<WEB_EC2_PRIVATE_IP> ansible_user=ubuntu ansible_ssh_private_key_file=~/aws-eks.pem

[app]
<APP_EC2_PRIVATE_IP> ansible_user=ubuntu ansible_ssh_private_key_file=~/aws-eks.pem
```

### Step 2: Ping All Hosts

```bash
ansible all -i hosts.ini -m ping
```

* Ensure all hosts are reachable

### Step 3: Run Playbook to Configure Web/App

```bash
ansible-playbook -i hosts.ini setup-web.yml
ansible-playbook -i hosts.ini setup-app.yml
```

### Step 4: Verify Services

* Nginx is running on web EC2
* Application tier configured
* Database connection verified

---

## 3. Optional: Capture Additional Screenshots

* Web application response
* RDS endpoint connectivity
* Security group rules
* Auto Scaling group activities

---

## 4. Deletion / Cleanup Instructions

### Step 1: Destroy Terraform Resources

```bash
cd ~/terraform-aws-production-infra
terraform destroy -auto-approve
```

### Step 2: Verify AWS Resources

* EC2 instances terminated
* RDS database deleted
* VPC, subnets, IGW, NAT Gateway removed
* S3 bucket and DynamoDB table cleaned

### Step 3: Remove Local Terraform Files

```bash
rm -rf terraform.tfstate terraform.tfstate.backup .terraform/
```

### Step 4: Optional Ansible Cleanup

* Remove any deployed configurations manually if needed

---

## 5. Notes / Best Practices

1. Always validate Terraform before applying.
2. Keep your `.pem` file secure.
3. Take screenshots for portfolio or documentation.
4. Follow AWS best practices for multi-tier architecture.
5. Ensure resources are destroyed to avoid unnecessary costs.

---

## Project Guide

This project was designed and executed under the guidance of **Shubham Londhe**.

```
