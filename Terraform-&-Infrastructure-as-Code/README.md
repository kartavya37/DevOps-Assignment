# Session 18: Terraform & Infrastructure as Code

**Name:** Kartavya Panchal  
**Roll No.:** 24BCS10343

## Folder structure

```text
Terraform-&-Infrastructure-as-Code/
├── README.md                     # this file
├── terraform-s3-demo/            # Task 1: Terraform project for an S3 bucket
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   ├── README.md                 # full workflow with real output
│   ├── .gitignore
│   └── .terraform.lock.hcl
├── aws-services/                 # Task 2: AWS services research
│   ├── 01-iam/README.md
│   ├── 02-ec2/README.md
│   ├── 03-s3/README.md
│   ├── 04-vpc/README.md
│   └── 05-dynamodb-rds/README.md
└── screenshots/                  # terminal screenshots of the commands
```

## Important: local AWS emulator, not a real AWS account

I do not have an AWS account. For the hands-on parts, I used **[Moto server](https://github.com/getmoto/moto)** (Docker image `motoserver/moto`, moto 5.2.3), a free local AWS emulator, on `http://localhost:4566`.

- All Terraform and AWS CLI output in this folder comes from the emulator. **No resource existed on real AWS.**
- The account ID `123456789012` and the access key `AKIAIOSFODNN7EXAMPLE` in the output are the fixed Moto test values.
- First, I tried LocalStack. The current LocalStack image stops at start without an auth token ("License activation failed"). So I used Moto, which needs no account.
- The Terraform code is normal AWS code. Only the block between `# EMULATOR START` and `# EMULATOR END` in `provider.tf` points to the emulator. The [Run on real AWS](terraform-s3-demo/README.md#run-on-real-aws) section shows how to remove it.

Start the emulator:

```bash
docker run -d --name moto -p 4566:5000 motoserver/moto
```

**WARNING:** Use dummy credentials when you work with the emulator. If real credentials are in `~/.aws`, a command without `--endpoint-url` can change a real account.

```bash
export AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test AWS_DEFAULT_REGION=us-east-1
export AWS_SHARED_CREDENTIALS_FILE=/dev/null AWS_CONFIG_FILE=/dev/null
unset AWS_PROFILE
```

## Task 1: Terraform S3 Demo

**Full document with all commands, output and screenshots: [terraform-s3-demo/README.md](terraform-s3-demo/README.md)**

The project creates one S3 bucket (`kartavya-s18-terraform-demo`) with versioning, SSE-S3 encryption, a public access block and tags. It has the six files from the brief, plus `.gitignore` and the provider lock file.

| File | Content |
|------|---------|
| [provider.tf](terraform-s3-demo/provider.tf) | `terraform` block (Terraform `>= 1.6.0`, AWS provider `~> 6.0`), `provider "aws"` with the emulator block and `default_tags` |
| [variables.tf](terraform-s3-demo/variables.tf) | `aws_region`, `bucket_name` (with validation), `environment` (with validation), `versioning_enabled` |
| [terraform.tfvars](terraform-s3-demo/terraform.tfvars) | values for the variables |
| [main.tf](terraform-s3-demo/main.tf) | `aws_s3_bucket`, `aws_s3_bucket_versioning`, `aws_s3_bucket_server_side_encryption_configuration`, `aws_s3_bucket_public_access_block` |
| [outputs.tf](terraform-s3-demo/outputs.tf) | `bucket_name`, `bucket_arn`, `bucket_region`, `versioning_status` |

Workflow that I ran (all output is in the project README):

| Step | Command | Result | Screenshot |
|------|---------|--------|------------|
| 1 | `terraform init` | AWS provider v6.67.0 installed, lock file created | [01](screenshots/01-terraform-init.png) |
| 2 | `terraform fmt`, `terraform validate` | format correct, "The configuration is valid." | [02](screenshots/02-terraform-fmt-validate.png) |
| 3 | `terraform plan -out=tfplan` | "Plan: 4 to add, 0 to change, 0 to destroy." | [03a](screenshots/03a-terraform-plan-top.png), [03b](screenshots/03b-terraform-plan-bottom.png) |
| 4 | `terraform apply tfplan` | "Apply complete! Resources: 4 added" | [04](screenshots/04-terraform-apply.png), [04b](screenshots/04b-tag-drift-fix.png) |
| 5 | `terraform show` | state with ARN, encryption, versioning, tags | [05a](screenshots/05a-terraform-show-bucket.png), [05b](screenshots/05b-terraform-show-settings.png) |
| 6 | `terraform output` | 4 output values | [06](screenshots/06-terraform-output-state.png) |
| 7 | `aws s3 ls`, `s3api get-bucket-*` | bucket exists with all settings; versioning keeps 2 versions | [07a](screenshots/07a-aws-cli-bucket-exists.png), [07b](screenshots/07b-aws-cli-bucket-settings.png), [07c](screenshots/07c-aws-cli-object-versions.png) |
| 8 | `terraform destroy` | "Destroy complete! Resources: 4 destroyed." | [08](screenshots/08-terraform-destroy.png) |
| 9 | `aws s3 ls`, `s3api head-bucket` | 0 buckets, `404 Not Found` | [09](screenshots/09-aws-cli-bucket-gone.png) |

![terraform apply](screenshots/04-terraform-apply.png)

![bucket gone after destroy](screenshots/09-aws-cli-bucket-gone.png)

## Task 2: AWS Services Research

Each service has its own README. Each README covers every point from the brief.

| Folder | Service | Topics |
|--------|---------|--------|
| [01-iam](aws-services/01-iam/README.md) | IAM - Governance | What is IAM, users, groups, roles, policies, permissions (evaluation logic), least privilege, best practices, use cases. Includes a CLI demo on the emulator. |
| [02-ec2](aws-services/02-ec2/README.md) | EC2 - Compute | What is EC2, AMI, instance types, key pairs, security groups, EBS, public vs private IP, instance lifecycle, use cases |
| [03-s3](aws-services/03-s3/README.md) | S3 - Storage | What is S3, buckets, objects, storage classes, versioning, lifecycle policies, encryption, bucket policies, use cases |
| [04-vpc](aws-services/04-vpc/README.md) | VPC - Networking | What is VPC, CIDR, subnets, route tables, Internet Gateway, NAT Gateway, security groups, network ACLs, public vs private subnet |
| [05-dynamodb-rds](aws-services/05-dynamodb-rds/README.md) | DynamoDB & RDS - Databases | DynamoDB: NoSQL, tables, items, attributes, partition key, sort key, use cases (with a CLI demo on the emulator). RDS: relational database, engines, DB instances, security, backups, Multi-AZ, read replicas, use cases |

## Cleanup

1. I removed all resources with `terraform destroy`. The AWS CLI showed that the bucket no longer existed.
2. I removed `.terraform/`, `terraform.tfstate`, `terraform.tfstate.backup` and `tfplan` from the project folder. The `.gitignore` keeps these files out of Git.
3. I stopped and removed the `moto` container.
