# AWS Serverless Application Demo 🚀

This project demonstrates a fully functional, production-ready serverless architecture on AWS, provisioned and managed via Terraform.  
It includes a modular setup for user authentication, backend logic, and data persistence — all serverless and scalable.

---

## 🔧 Features

- ✅ **User Authentication with AWS Cognito**
  - User Pool with MFA & Password Policies
  - User Groups (`admin`, `vendor`, `customer`, `driver`)
  - PostConfirmation & PreSignup Lambda Triggers

- ✅ **Secure Backend Logic with AWS Lambda**
  - Signup, Login, and Confirm endpoints
  - Python-based functions
  - Zipped and deployed with Terraform

- ✅ **RESTful API with Amazon API Gateway**
  - CORS Enabled
  - Throttling and Rate Limiting
  - Usage Plans and API Keys

- ✅ **Data Layer with DynamoDB**
  - Partition/Sort Key schema
  - Global Secondary Index (GSI)
  - Point-In-Time Recovery (PITR) enabled

- ✅ **Infrastructure as Code (IaC) with Terraform**
  - Modular structure (`cognito`, `lambda`, `apigateway`, `iam`, `dynamodb`)
  - Secure IAM Roles with least privilege
  - Clean variable definitions and outputs
  - `terraform.tfvars` for environment configuration

- ✅ **CI/CD Ready**
  - Includes sample `codepipeline.yml` file under `ci-cd/`

---

## 📁 Project Structure

```bash
aws-serverless-app-demo/
├── lambda/
│   ├── *.py           # Lambda source code
│   └── *.zip          # Zipped deployment packages
└── terraform/
    ├── main.tf        # Root infrastructure file
    ├── provider.tf    # AWS Provider setup
    ├── outputs.tf     # Global outputs
    ├── variables.tf   # Global variables
    ├── terraform.tfvars   # Environment-specific values
    ├── modules/
    │   ├── lambda/    # Lambda definition
    │   ├── cognito/   # Cognito User Pool & Triggers
    │   ├── apigateway/
    │   ├── dynamodb/
    │   └── iam/
    └── ci-cd/
        └── codepipeline.yml
