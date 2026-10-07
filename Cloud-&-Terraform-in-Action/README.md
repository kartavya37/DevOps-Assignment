# Session 19: Cloud & Terraform in Action

**Name:** Kartavya Panchal  
**Roll No.:** 24BCS10343

## Folder structure

```text
Cloud-&-Terraform-in-Action/
├── README.md                    # this file
├── terraform-project/           # the Terraform project
│   ├── providers.tf             # Terraform + AWS provider, emulator endpoints, default tags
│   ├── variables.tf             # 9 input variables, all with validation
│   ├── terraform.tfvars         # values for the variables
│   ├── locals.tf                # name prefix, common tags, availability zone data source
│   ├── network.tf               # VPC, public subnet, Internet Gateway, route table, association
│   ├── security.tf              # security group, IAM role, role policy, instance profile
│   ├── compute.tf               # EC2 instance (depends_on the route table association)
│   ├── storage.tf               # S3 bucket, versioning, encryption, public access block, object
│   ├── outputs.tf               # 11 outputs
│   ├── .gitignore
│   └── .terraform.lock.hcl
├── diagrams/
│   ├── terraform-graph.dot      # raw output of "terraform graph"
│   └── terraform-graph.png      # the same graph rendered with Graphviz
└── screenshots/                 # terminal screenshots of every step
```

## Important: local AWS emulator, not a real AWS account

I do not have an AWS account. I ran this project against **[Moto server](https://github.com/getmoto/moto)** (Docker image `motoserver/moto`, moto 5.2.3), a free local AWS emulator on `http://localhost:4566`.

- All output in this document comes from the emulator. **No resource existed on real AWS, and nothing cost money.**
- **The EC2 instance is simulated.** Moto keeps a record of the instance with an ID, a state (`running`), a private IP and a public IP. No virtual machine starts, the `user_data` script does not run, and nginx is not installed. The public IP `54.214.45.206` is a value that Moto made. It does not belong to this project, so I did not connect to it.
- The account ID `123456789012` is the fixed Moto test account.
- First, I tried LocalStack. The current LocalStack image needs an auth token and stops at start without it. Moto needs no account and supports EC2, VPC, S3 and IAM.
- The Terraform code is standard AWS code. Only the block between `# EMULATOR START` and `# EMULATOR END` in [providers.tf](terraform-project/providers.tf) points to the emulator. Refer to [Run on real AWS](#run-on-real-aws).

## Architecture

```mermaid
flowchart TB
    USER((Internet user))
    ADMIN((Admin<br/>203.0.113.10/32))
    TF[Terraform CLI<br/>hashicorp/aws v6.67.0]

    subgraph AWS["AWS region us-east-1 (Moto emulator)"]
        subgraph VPC["VPC s19-web-dev-vpc 10.20.0.0/16"]
            IGW[Internet Gateway<br/>s19-web-dev-igw]
            RT["Route table s19-web-dev-public-rt<br/>10.20.0.0/16 → local<br/>0.0.0.0/0 → IGW"]
            subgraph SUB["Public subnet 10.20.1.0/24 (us-east-1a)"]
                subgraph SG["Security group s19-web-dev-web-sg<br/>in: 80 from 0.0.0.0/0, 22 from admin /32<br/>out: all"]
                    EC2["EC2 s19-web-dev-web<br/>t3.micro, Amazon Linux 2<br/>gp3 encrypted root, IMDSv2"]
                end
            end
        end
        ROLE[IAM role + instance profile<br/>s3:GetObject, s3:ListBucket]
        S3[(S3 bucket kartavya-s19-web-assets<br/>versioning, SSE-S3, public access block<br/>deployment/info.json)]
    end

    USER -->|HTTP 80| IGW
    ADMIN -->|SSH 22| IGW
    IGW --> RT --> SUB
    EC2 -. assumes .-> ROLE
    ROLE -. read only .-> S3
    TF -->|plan / apply / destroy| AWS
```

Terraform also produced a dependency graph. I rendered it with Graphviz (`terraform graph | dot -Tpng`). An arrow points from a resource to the resource that it depends on.

![terraform graph](diagrams/terraform-graph.png)

## What the project demonstrates

| Brief requirement | Where it is in this project |
|-------------------|-----------------------------|
| Terraform providers | [providers.tf](terraform-project/providers.tf): `required_providers` pins `hashicorp/aws ~> 6.0`. The `provider "aws"` block sets the region, endpoints and `default_tags`. `terraform providers` shows the tree. |
| Variables | [variables.tf](terraform-project/variables.tf): 9 typed variables. Every variable has a `validation` block (regex, `contains`, `cidrhost`). [terraform.tfvars](terraform-project/terraform.tfvars) gives the values. |
| Resources | 15 managed resources in 5 files, plus 1 data source (`aws_availability_zones`). |
| Outputs | [outputs.tf](terraform-project/outputs.tf): 11 outputs (IDs, IPs, URL, bucket name and ARN). |
| Dependencies | Implicit: references such as `vpc_id = aws_vpc.main.id`. Explicit: `depends_on` in [compute.tf](terraform-project/compute.tf). `terraform graph` shows all of them. |
| AWS infrastructure | VPC, subnet, Internet Gateway, route table, security group, IAM role, EC2, S3 (on the emulator). |
| Terraform state | `terraform state list`, `terraform state show`, drift correction. |
| plan / apply / destroy | Steps 4, 6 and 9 below. |

### Dependencies

**Implicit dependencies.** When one resource uses an attribute of another resource, Terraform creates the referenced resource first. Examples from the code:

```hcl
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id                                 # needs the VPC
  availability_zone = data.aws_availability_zones.available.names[0]  # needs the data source
  ...
}

resource "aws_iam_role_policy" "ec2_read_assets" {
  role = aws_iam_role.ec2.id                                          # needs the role
  policy = jsonencode({
    ...
    Resource = [aws_s3_bucket.assets.arn, "${aws_s3_bucket.assets.arn}/*"]  # needs the bucket
  })
}
```

**Explicit dependency (`depends_on`).** The EC2 `user_data` script downloads nginx at first boot, so the subnet must have its internet route before the instance starts. The instance has no attribute that refers to the route table association. Terraform cannot see this dependency, so I added it:

```hcl
resource "aws_instance" "web" {
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2.name
  ...
  depends_on = [aws_route_table_association.public]
}
```

The graph shows the edge `aws_instance.web -> aws_route_table_association.public`. In the apply output (Step 6), the instance starts only after "aws_route_table_association.public: Creation complete".

### Variables with validation

```hcl
variable "allowed_ssh_cidr" {
  type = string
  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0)) && var.allowed_ssh_cidr != "0.0.0.0/0"
    error_message = "The SSH CIDR must be a valid CIDR block and must not be 0.0.0.0/0."
  }
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
  validation {
    condition     = contains(["t2.micro", "t3.micro", "t3.small"], var.instance_type)
    error_message = "The instance type must be t2.micro, t3.micro or t3.small (small and low cost)."
  }
}
```

## Prerequisites

1. Install Terraform 1.6 or later. I used Terraform v1.16.4.
2. Install the AWS CLI v2. I used aws-cli 2.36.29.
3. Install Graphviz for the graph image (`brew install graphviz`). This step is optional.
4. Start the emulator.

```bash
docker run -d --name moto -p 4566:5000 motoserver/moto
```

**WARNING:** Use dummy credentials in every shell. If real credentials are in `~/.aws`, a wrong command can change a real account.

```bash
export AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test AWS_DEFAULT_REGION=us-east-1
export AWS_SHARED_CREDENTIALS_FILE=/dev/null AWS_CONFIG_FILE=/dev/null
unset AWS_PROFILE
```

## Step 0: Make sure that the emulator works and find an AMI

1. Make sure that the `moto` container runs.
2. Run `sts get-caller-identity` against the emulator.
3. Find an Amazon Linux 2 AMI that the emulator knows.

![emulator check and AMI](screenshots/00-emulator-check-and-ami.png)

```console
$ docker ps --filter name=moto --format "{{.Names}}  {{.Image}}  {{.Status}}  {{.Ports}}"
moto  motoserver/moto  Up 17 minutes  0.0.0.0:4566->5000/tcp, [::]:4566->5000/tcp

$ aws --endpoint-url http://localhost:4566 sts get-caller-identity --output text
123456789012	arn:aws:sts::123456789012:user/moto	AKIAIOSFODNN7EXAMPLE

$ aws --endpoint-url http://localhost:4566 ec2 describe-images --owners amazon --filters 'Name=name,Values=amzn2-ami-hvm-2.0.2026*' --query 'Images[].[ImageId,Name,Architecture]' --output table
--------------------------------------------------------------------------------
|                                DescribeImages                                |
+------------------------+-------------------------------------------+---------+
|  ami-05448533fbe614dce |  amzn2-ami-hvm-2.0.20260727.0-x86_64-gp2  |  x86_64 |
|  ami-013dd3b45d86cef0e |  amzn2-ami-hvm-2.0.20260727.0-x86_64-ebs  |  x86_64 |
|  ami-0f3f4d46a891edf26 |  amzn2-ami-hvm-2.0.20260727.0-arm64-gp2   |  arm64  |
+------------------------+-------------------------------------------+---------+
```

The account is the Moto test account, so the CLI talks to the emulator. I put `ami-05448533fbe614dce` (Amazon Linux 2, x86_64, gp2) in `terraform.tfvars`.

## Step 1: terraform init

1. Go to `terraform-project/`.
2. Run `terraform init`.

![terraform init](screenshots/01-terraform-init.png)

```console
$ terraform init -no-color | head -n 12
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 6.0"...
- Installing hashicorp/aws v6.67.0...
- Installed hashicorp/aws v6.67.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.
```

Terraform downloaded the AWS provider v6.67.0 and wrote `.terraform.lock.hcl`.

## Step 2: terraform fmt, validate and providers

![fmt validate providers](screenshots/02-fmt-validate-providers.png)

```console
$ terraform fmt -check; echo "fmt exit code: $?"
fmt exit code: 0

$ terraform validate -no-color
Success! The configuration is valid.


$ terraform providers -no-color

Providers required by configuration:
.
└── provider[registry.terraform.io/hashicorp/aws] ~> 6.0
```

All files have the standard format. The configuration is valid. The project uses one provider, `hashicorp/aws`, with the constraint `~> 6.0`.

## Step 3: Test the variable validation

1. Give two values that break the rules: a large instance type and SSH open to the world.

![variable validation](screenshots/03-variable-validation.png)

```console
$ terraform plan -no-color -var="instance_type=m5.4xlarge" -var="allowed_ssh_cidr=0.0.0.0/0" 2>&1 | tail -n 22
Error: Invalid value for variable

  on variables.tf line 55:
  55: variable "allowed_ssh_cidr" {
    ├────────────────
    │ var.allowed_ssh_cidr is "0.0.0.0/0"

The SSH CIDR must be a valid CIDR block and must not be 0.0.0.0/0.

This was checked by the validation rule at variables.tf:59,3-13.

Error: Invalid value for variable

  on variables.tf line 65:
  65: variable "instance_type" {
    ├────────────────
    │ var.instance_type is "m5.4xlarge"

The instance type must be t2.micro, t3.micro or t3.small (small and low
cost).

This was checked by the validation rule at variables.tf:70,3-13.
```

Terraform stopped with two errors and created nothing. The validation rules block expensive instance types and SSH access from `0.0.0.0/0`.

## Step 4: terraform plan

1. Run `terraform plan -out=tfplan`.

![plan summary](screenshots/04a-terraform-plan-summary.png)

```console
$ terraform plan -no-color -out=tfplan | grep -E "will be created|^Plan:"
  # aws_iam_instance_profile.ec2 will be created
  # aws_iam_role.ec2 will be created
  # aws_iam_role_policy.ec2_read_assets will be created
  # aws_instance.web will be created
  # aws_internet_gateway.main will be created
  # aws_route_table.public will be created
  # aws_route_table_association.public will be created
  # aws_s3_bucket.assets will be created
  # aws_s3_bucket_public_access_block.assets will be created
  # aws_s3_bucket_server_side_encryption_configuration.assets will be created
  # aws_s3_bucket_versioning.assets will be created
  # aws_s3_object.deployment_info will be created
  # aws_security_group.web will be created
  # aws_subnet.public will be created
  # aws_vpc.main will be created
Plan: 15 to add, 0 to change, 0 to destroy.
```

![plan outputs](screenshots/04b-terraform-plan-outputs.png)

```console
$ terraform plan -no-color -out=tfplan | tail -n 24
        }
    }

Plan: 15 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + availability_zone   = "us-east-1a"
  + bucket_arn          = (known after apply)
  + bucket_name         = "kartavya-s19-web-assets"
  + instance_id         = (known after apply)
  + instance_private_ip = (known after apply)
  + instance_public_ip  = (known after apply)
  + internet_gateway_id = (known after apply)
  + public_subnet_id    = (known after apply)
  + security_group_id   = (known after apply)
  + vpc_id              = (known after apply)
  + web_url             = (known after apply)

─────────────────────────────────────────────────────────────────────────────

Saved the plan to: tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "tfplan"
```

Terraform will create 15 resources. IDs and IP addresses are `(known after apply)`, because AWS sets them at creation. `availability_zone` and `bucket_name` are already known: they come from the data source and from a variable.

## Step 5: terraform graph

1. Run `terraform graph` to print the dependency graph in DOT format.
2. Render it to PNG with Graphviz.

![terraform graph](screenshots/05-terraform-graph.png)

```console
$ terraform graph | grep -- "->"
  "aws_iam_instance_profile.ec2" -> "aws_iam_role.ec2";
  "aws_iam_role_policy.ec2_read_assets" -> "aws_iam_role.ec2";
  "aws_iam_role_policy.ec2_read_assets" -> "aws_s3_bucket.assets";
  "aws_instance.web" -> "aws_iam_instance_profile.ec2";
  "aws_instance.web" -> "aws_route_table_association.public";
  "aws_instance.web" -> "aws_security_group.web";
  "aws_internet_gateway.main" -> "aws_vpc.main";
  "aws_route_table.public" -> "aws_internet_gateway.main";
  "aws_route_table_association.public" -> "aws_route_table.public";
  "aws_route_table_association.public" -> "aws_subnet.public";
  "aws_s3_bucket_public_access_block.assets" -> "aws_s3_bucket.assets";
  "aws_s3_bucket_server_side_encryption_configuration.assets" -> "aws_s3_bucket.assets";
  "aws_s3_bucket_versioning.assets" -> "aws_s3_bucket.assets";
  "aws_s3_object.deployment_info" -> "aws_instance.web";
  "aws_s3_object.deployment_info" -> "aws_s3_bucket.assets";
  "aws_security_group.web" -> "aws_vpc.main";
  "aws_subnet.public" -> "data.aws_availability_zones.available";
  "aws_subnet.public" -> "aws_vpc.main";

$ terraform graph | dot -Tpng -o ../diagrams/terraform-graph.png && file ../diagrams/terraform-graph.png
../diagrams/terraform-graph.png: PNG image data, 1932 x 413, 8-bit/color RGBA, non-interlaced
```

Each line `A -> B` means "A depends on B". Terraform creates B before A and removes A before B. Terraform creates resources with no path between them (for example the VPC and the S3 bucket) in parallel. The file [diagrams/terraform-graph.dot](diagrams/terraform-graph.dot) has the full output. The rendered image is in the [Architecture](#architecture) section.

## Step 6: terraform apply

1. Make sure that the endpoints in `providers.tf` point to `http://localhost:4566`.
2. Run `terraform apply tfplan`.

![apply part 1](screenshots/06a-terraform-apply-part1.png)

![apply part 2](screenshots/06b-terraform-apply-part2.png)

I saved the full apply output to a log file. The two screenshots show that log in two parts.

```console
$ terraform apply -no-color tfplan
aws_iam_role.ec2: Creating...
aws_vpc.main: Creating...
aws_s3_bucket.assets: Creating...
aws_vpc.main: Creation complete after 0s [id=vpc-908405199ca545a63]
aws_internet_gateway.main: Creating...
aws_subnet.public: Creating...
aws_security_group.web: Creating...
aws_internet_gateway.main: Creation complete after 0s [id=igw-e0699a36dd13fa38a]
aws_s3_bucket.assets: Creation complete after 0s [id=kartavya-s19-web-assets]
aws_s3_bucket_versioning.assets: Creating...
aws_s3_bucket_public_access_block.assets: Creating...
aws_s3_bucket_server_side_encryption_configuration.assets: Creating...
aws_route_table.public: Creating...
aws_s3_bucket_server_side_encryption_configuration.assets: Creation complete after 0s [id=kartavya-s19-web-assets]
aws_s3_bucket_public_access_block.assets: Creation complete after 0s [id=kartavya-s19-web-assets]
aws_iam_role.ec2: Creation complete after 0s [id=s19-web-dev-ec2-role]
aws_iam_instance_profile.ec2: Creating...
aws_iam_role_policy.ec2_read_assets: Creating...
aws_iam_role_policy.ec2_read_assets: Creation complete after 0s [id=s19-web-dev-ec2-role:s19-web-dev-read-assets]
aws_security_group.web: Creation complete after 1s [id=sg-791a10d541a237110]
aws_route_table.public: Creation complete after 1s [id=rtb-cb0df0d5333889d0c]
aws_s3_bucket_versioning.assets: Creation complete after 2s [id=kartavya-s19-web-assets]
aws_iam_instance_profile.ec2: Creation complete after 6s [id=s19-web-dev-ec2-profile]
aws_subnet.public: Still creating... [00m10s elapsed]
aws_subnet.public: Creation complete after 10s [id=subnet-74d7fe917396facb5]
aws_route_table_association.public: Creating...
aws_route_table_association.public: Creation complete after 0s [id=rtbassoc-076265c54c45d6154]
aws_instance.web: Creating...
aws_instance.web: Still creating... [00m10s elapsed]
aws_instance.web: Creation complete after 11s [id=i-f96bf821caf891f5b]
aws_s3_object.deployment_info: Creating...
aws_s3_object.deployment_info: Creation complete after 0s [id=kartavya-s19-web-assets/deployment/info.json]

Apply complete! Resources: 15 added, 0 changed, 0 destroyed.

Outputs:

availability_zone = "us-east-1a"
bucket_arn = "arn:aws:s3:::kartavya-s19-web-assets"
bucket_name = "kartavya-s19-web-assets"
instance_id = "i-f96bf821caf891f5b"
instance_private_ip = "10.20.1.4"
instance_public_ip = "54.214.45.206"
internet_gateway_id = "igw-e0699a36dd13fa38a"
public_subnet_id = "subnet-74d7fe917396facb5"
security_group_id = "sg-791a10d541a237110"
vpc_id = "vpc-908405199ca545a63"
web_url = "http://54.214.45.206"
```

The order follows the graph. The IAM role, the VPC and the S3 bucket started at the same time, because they do not depend on each other. The subnet, the Internet Gateway and the security group waited for the VPC. The EC2 instance started only after the route table association (the `depends_on`). The S3 object came last, because its content uses `aws_instance.web.id`.

### Emulator limitation: S3 bucket tags

AWS provider v6 sends bucket tags inside the `CreateBucket` request. Moto ignores tags in that request. The next `terraform plan` found this **drift** (1 to change). A second `terraform apply` set the tags with `PutBucketTagging`. On real AWS, the first apply sets the tags.

![bucket tag fix](screenshots/07-bucket-tag-fix.png)

```console
$ terraform apply -no-color -auto-approve | grep -E "will be updated|Plan:|Modif|Apply complete"
  # aws_s3_bucket.assets will be updated in-place
Plan: 0 to add, 1 to change, 0 to destroy.
aws_s3_bucket.assets: Modifying... [id=kartavya-s19-web-assets]
aws_s3_bucket.assets: Modifications complete after 0s [id=kartavya-s19-web-assets]
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

$ terraform plan -no-color -detailed-exitcode | grep "No changes"; echo "plan exit code: ${PIPESTATUS[0]}"
No changes. Your infrastructure matches the configuration.
plan exit code: 0
```

After this, `terraform plan -detailed-exitcode` returned exit code 0: the real resources match the configuration.

## Step 7: Terraform state

Terraform keeps a record of every resource that it manages in `terraform.tfstate`. The state maps each resource address (for example `aws_vpc.main`) to the real ID (`vpc-908405199ca545a63`).

1. Run `terraform state list` to list all resources in the state.
2. Run `terraform output` to read the outputs from the state.

![state list and output](screenshots/08-terraform-state-list-output.png)

```console
$ terraform state list
data.aws_availability_zones.available
aws_iam_instance_profile.ec2
aws_iam_role.ec2
aws_iam_role_policy.ec2_read_assets
aws_instance.web
aws_internet_gateway.main
aws_route_table.public
aws_route_table_association.public
aws_s3_bucket.assets
aws_s3_bucket_public_access_block.assets
aws_s3_bucket_server_side_encryption_configuration.assets
aws_s3_bucket_versioning.assets
aws_s3_object.deployment_info
aws_security_group.web
aws_subnet.public
aws_vpc.main

$ terraform output
availability_zone = "us-east-1a"
bucket_arn = "arn:aws:s3:::kartavya-s19-web-assets"
bucket_name = "kartavya-s19-web-assets"
instance_id = "i-f96bf821caf891f5b"
instance_private_ip = "10.20.1.4"
instance_public_ip = "54.214.45.206"
internet_gateway_id = "igw-e0699a36dd13fa38a"
public_subnet_id = "subnet-74d7fe917396facb5"
security_group_id = "sg-791a10d541a237110"
vpc_id = "vpc-908405199ca545a63"
web_url = "http://54.214.45.206"
```

3. Run `terraform state show <address>` to see all attributes of one resource.

![state show vpc](screenshots/09a-terraform-state-show-vpc.png)

```console
$ terraform state show -no-color aws_vpc.main
# aws_vpc.main:
resource "aws_vpc" "main" {
    arn                                  = "arn:aws:ec2:us-east-1:123456789012:vpc/vpc-908405199ca545a63"
    assign_generated_ipv6_cidr_block     = false
    cidr_block                           = "10.20.0.0/16"
    default_network_acl_id               = "acl-4c7e12fe249261ace"
    default_route_table_id               = "rtb-3b977490c9d3b3123"
    default_security_group_id            = "sg-dcab5e331e59d1f0c"
    dhcp_options_id                      = "default"
    enable_dns_hostnames                 = true
    enable_dns_support                   = true
    enable_network_address_usage_metrics = false
    id                                   = "vpc-908405199ca545a63"
    instance_tenancy                     = "default"
    ipv6_association_id                  = null
    ipv6_cidr_block                      = null
    ipv6_cidr_block_network_border_group = null
    ipv6_ipam_pool_id                    = null
    ipv6_netmask_length                  = 0
    main_route_table_id                  = "rtb-3b977490c9d3b3123"
    owner_id                             = "123456789012"
    region                               = "us-east-1"
    tags                                 = {
        "Name" = "s19-web-dev-vpc"
    }
    tags_all                             = {
        "Environment" = "dev"
        "ManagedBy"   = "Terraform"
        "Name"        = "s19-web-dev-vpc"
        "Project"     = "s19-web"
        "Session"     = "19"
    }
}
```

![state show ec2](screenshots/09b-terraform-state-show-ec2.png)

```console
$ terraform state show -no-color aws_instance.web | grep -E "^#|^resource| ami | id  | instance_state|instance_type|private_ip  |public_ip  |subnet_id|iam_instance_profile|http_tokens|volume_type|encrypted|\"Name\"" 
# aws_instance.web:
resource "aws_instance" "web" {
    ami                                  = "ami-05448533fbe614dce"
    iam_instance_profile                 = "s19-web-dev-ec2-profile"
    id                                   = "i-f96bf821caf891f5b"
    instance_state                       = "running"
    instance_type                        = "t3.micro"
    private_ip                           = "10.20.1.4"
    public_ip                            = "54.214.45.206"
    subnet_id                            = "subnet-74d7fe917396facb5"
        "Name" = "s19-web-dev-web"
        "Name"        = "s19-web-dev-web"
        http_tokens                 = "required"
        encrypted             = true
        volume_type           = "gp3"

$ terraform state show -no-color aws_route_table.public | grep -E "cidr_block|gateway_id  "
            carrier_gateway_id         = null
            cidr_block                 = "0.0.0.0/0"
            egress_only_gateway_id     = null
            gateway_id                 = "igw-e0699a36dd13fa38a"
            ipv6_cidr_block            = null
            local_gateway_id           = null
            nat_gateway_id             = null
            transit_gateway_id         = null
```

The state has the values that AWS set. Examples are the VPC ID, the default route table, the default network ACL, and the private IP `10.20.1.4` from the subnet `10.20.1.0/24`. The route table sends `0.0.0.0/0` to the Internet Gateway. The instance uses IMDSv2 (`http_tokens = "required"`) and an encrypted gp3 root volume.

**CAUTION:** Do not commit `terraform.tfstate` to Git. It can contain secrets, and two people who change local state files at the same time can damage the infrastructure. For a team, use a remote backend, for example S3 with `use_lockfile = true`. The `.gitignore` excludes all state files.

## Step 8: Make sure that the resources exist (AWS CLI)

Run `describe` commands against the emulator. Each command filters by the `Project = s19-web` tag that `default_tags` added.

### Network: VPC, subnet, Internet Gateway, route table

![aws cli network](screenshots/10a-aws-cli-network.png)

```console
$ aws --endpoint-url http://localhost:4566 ec2 describe-vpcs --filters Name=tag:Project,Values=s19-web --query 'Vpcs[].[VpcId,CidrBlock,State,Tags[?Key==`Name`]|[0].Value]' --output table
---------------------------------------------------------------------------
|                              DescribeVpcs                               |
+------------------------+---------------+------------+-------------------+
|  vpc-908405199ca545a63 |  10.20.0.0/16 |  available |  s19-web-dev-vpc  |
+------------------------+---------------+------------+-------------------+

$ aws --endpoint-url http://localhost:4566 ec2 describe-subnets --filters Name=tag:Project,Values=s19-web --query 'Subnets[].[SubnetId,CidrBlock,AvailabilityZone,MapPublicIpOnLaunch]' --output table
--------------------------------------------------------------------
|                          DescribeSubnets                         |
+---------------------------+---------------+-------------+--------+
|  subnet-74d7fe917396facb5 |  10.20.1.0/24 |  us-east-1a |  True  |
+---------------------------+---------------+-------------+--------+

$ aws --endpoint-url http://localhost:4566 ec2 describe-internet-gateways --filters Name=tag:Project,Values=s19-web --query 'InternetGateways[].[InternetGatewayId,Attachments[0].VpcId,Attachments[0].State]' --output table
-----------------------------------------------------------------
|                   DescribeInternetGateways                    |
+------------------------+-------------------------+------------+
|  igw-e0699a36dd13fa38a |  vpc-908405199ca545a63  |  available |
+------------------------+-------------------------+------------+

$ aws --endpoint-url http://localhost:4566 ec2 describe-route-tables --filters Name=tag:Project,Values=s19-web --query 'RouteTables[].Routes[].[DestinationCidrBlock,GatewayId,State]' --output table
-----------------------------------------------------
|                DescribeRouteTables                |
+---------------+-------------------------+---------+
|  10.20.0.0/16 |  local                  |  active |
|  0.0.0.0/0    |  igw-e0699a36dd13fa38a  |  active |
+---------------+-------------------------+---------+
```

### Security group and EC2 instance

![aws cli sg and ec2](screenshots/10b-aws-cli-sg-ec2.png)

```console
$ aws --endpoint-url http://localhost:4566 ec2 describe-security-groups --filters Name=group-name,Values=s19-web-dev-web-sg --query 'SecurityGroups[].IpPermissions[].[IpProtocol,FromPort,ToPort,IpRanges[0].CidrIp,IpRanges[0].Description]' --output table
------------------------------------------------------------------------
|                        DescribeSecurityGroups                        |
+-----+-----+-----+-------------------+--------------------------------+
|  tcp|  22 |  22 |  203.0.113.10/32  |  SSH from the admin CIDR only  |
|  tcp|  80 |  80 |  0.0.0.0/0        |  HTTP                          |
+-----+-----+-----+-------------------+--------------------------------+

$ aws --endpoint-url http://localhost:4566 ec2 describe-instances --filters Name=tag:Project,Values=s19-web --query 'Reservations[].Instances[].{ID:InstanceId,State:State.Name,Type:InstanceType,AMI:ImageId,PrivateIP:PrivateIpAddress,PublicIP:PublicIpAddress,Subnet:SubnetId}' --output table
-------------------------------------------
|            DescribeInstances            |
+------------+----------------------------+
|  AMI       |  ami-05448533fbe614dce     |
|  ID        |  i-f96bf821caf891f5b       |
|  PrivateIP |  10.20.1.4                 |
|  PublicIP  |  54.214.45.206             |
|  State     |  running                   |
|  Subnet    |  subnet-74d7fe917396facb5  |
|  Type      |  t3.micro                  |
+------------+----------------------------+
```

The emulator reports the instance as `running` in the public subnet, with the AMI and the instance type from the variables. This is a simulated instance. No virtual machine runs.

### S3 bucket and IAM role

![aws cli s3 and iam](screenshots/10c-aws-cli-s3-iam.png)

```console
$ aws --endpoint-url http://localhost:4566 s3 ls
2026-10-07 17:08:19 kartavya-s19-web-assets

$ aws --endpoint-url http://localhost:4566 s3 ls --recursive s3://kartavya-s19-web-assets/
2026-10-07 17:08:39        110 deployment/info.json

$ aws --endpoint-url http://localhost:4566 s3 cp s3://kartavya-s19-web-assets/deployment/info.json - ; echo
{"environment":"dev","instance_id":"i-f96bf821caf891f5b","project":"s19-web","vpc_id":"vpc-908405199ca545a63"}

$ aws --endpoint-url http://localhost:4566 s3api get-bucket-versioning --bucket kartavya-s19-web-assets --output text
Enabled

$ aws --endpoint-url http://localhost:4566 iam get-role --role-name s19-web-dev-ec2-role --query 'Role.[RoleName,Arn]' --output text
s19-web-dev-ec2-role	arn:aws:iam::123456789012:role/s19-web-dev-ec2-role

$ aws --endpoint-url http://localhost:4566 iam get-instance-profile --instance-profile-name s19-web-dev-ec2-profile --query 'InstanceProfile.Roles[].RoleName' --output text
s19-web-dev-ec2-role
```

`deployment/info.json` contains the real VPC ID and instance ID. Terraform wrote these values into the object at apply time. This shows how outputs of one resource become inputs of another resource.

## Step 9: terraform destroy

**CAUTION:** `terraform destroy` removes every resource in the state. There is no undo. On real AWS, the data in the bucket is lost.

1. Run `terraform plan -destroy` to preview the removal.
2. Run `terraform destroy` and type `yes`.

```console
$ terraform plan -destroy -no-color | grep -E "will be destroyed|^Plan:"
  # aws_iam_instance_profile.ec2 will be destroyed
  # aws_iam_role.ec2 will be destroyed
  # aws_iam_role_policy.ec2_read_assets will be destroyed
  # aws_instance.web will be destroyed
  # aws_internet_gateway.main will be destroyed
  # aws_route_table.public will be destroyed
  # aws_route_table_association.public will be destroyed
  # aws_s3_bucket.assets will be destroyed
  # aws_s3_bucket_public_access_block.assets will be destroyed
  # aws_s3_bucket_server_side_encryption_configuration.assets will be destroyed
  # aws_s3_bucket_versioning.assets will be destroyed
  # aws_s3_object.deployment_info will be destroyed
  # aws_security_group.web will be destroyed
  # aws_subnet.public will be destroyed
  # aws_vpc.main will be destroyed
Plan: 0 to add, 0 to change, 15 to destroy.
```

![terraform destroy](screenshots/11-terraform-destroy.png)

I saved the full destroy output to a log file. The screenshot shows the last part of that log.

```console
$ echo yes | terraform destroy -no-color   (last part of the output)
Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: 
aws_s3_bucket_public_access_block.assets: Destroying... [id=kartavya-s19-web-assets]
aws_s3_bucket_versioning.assets: Destroying... [id=kartavya-s19-web-assets]
aws_iam_role_policy.ec2_read_assets: Destroying... [id=s19-web-dev-ec2-role:s19-web-dev-read-assets]
aws_s3_bucket_server_side_encryption_configuration.assets: Destroying... [id=kartavya-s19-web-assets]
aws_s3_object.deployment_info: Destroying... [id=kartavya-s19-web-assets/deployment/info.json]
aws_s3_bucket_versioning.assets: Destruction complete after 0s
aws_iam_role_policy.ec2_read_assets: Destruction complete after 0s
aws_s3_object.deployment_info: Destruction complete after 0s
aws_s3_bucket_public_access_block.assets: Destruction complete after 0s
aws_s3_bucket_server_side_encryption_configuration.assets: Destruction complete after 0s
aws_instance.web: Destroying... [id=i-f96bf821caf891f5b]
aws_s3_bucket.assets: Destroying... [id=kartavya-s19-web-assets]
aws_s3_bucket.assets: Destruction complete after 0s
aws_instance.web: Still destroying... [id=i-f96bf821caf891f5b, 00m10s elapsed]
aws_instance.web: Destruction complete after 10s
aws_route_table_association.public: Destroying... [id=rtbassoc-076265c54c45d6154]
aws_iam_instance_profile.ec2: Destroying... [id=s19-web-dev-ec2-profile]
aws_security_group.web: Destroying... [id=sg-791a10d541a237110]
aws_route_table_association.public: Destruction complete after 0s
aws_iam_instance_profile.ec2: Destruction complete after 0s
aws_route_table.public: Destroying... [id=rtb-cb0df0d5333889d0c]
aws_iam_role.ec2: Destroying... [id=s19-web-dev-ec2-role]
aws_subnet.public: Destroying... [id=subnet-74d7fe917396facb5]
aws_subnet.public: Destruction complete after 0s
aws_iam_role.ec2: Destruction complete after 0s
aws_security_group.web: Destruction complete after 1s
aws_route_table.public: Destruction complete after 1s
aws_internet_gateway.main: Destroying... [id=igw-e0699a36dd13fa38a]
aws_internet_gateway.main: Destruction complete after 0s
aws_vpc.main: Destroying... [id=vpc-908405199ca545a63]
aws_vpc.main: Destruction complete after 0s

Destroy complete! Resources: 15 destroyed.
```

Terraform removed the resources in the reverse order of the graph. The S3 object went first, because nothing depends on it. The VPC went last, after the subnet, the route table, the security group and the Internet Gateway.

## Step 10: Make sure that the resources are gone

![resources gone](screenshots/12-aws-cli-resources-gone.png)

```console
$ aws --endpoint-url http://localhost:4566 ec2 describe-vpcs --filters Name=tag:Project,Values=s19-web --query 'length(Vpcs)'
0

$ aws --endpoint-url http://localhost:4566 ec2 describe-subnets --filters Name=tag:Project,Values=s19-web --query 'length(Subnets)'
0

$ aws --endpoint-url http://localhost:4566 ec2 describe-internet-gateways --filters Name=tag:Project,Values=s19-web --query 'length(InternetGateways)'
0

$ aws --endpoint-url http://localhost:4566 ec2 describe-security-groups --filters Name=group-name,Values=s19-web-dev-web-sg --query 'length(SecurityGroups)'
0

$ aws --endpoint-url http://localhost:4566 ec2 describe-instances --filters Name=tag:Project,Values=s19-web --query 'Reservations[].Instances[].[InstanceId,State.Name]' --output text
i-f96bf821caf891f5b	terminated

$ aws --endpoint-url http://localhost:4566 s3api head-bucket --bucket kartavya-s19-web-assets

aws: [ERROR]: An error occurred (404) when calling the HeadBucket operation: Not Found

$ aws --endpoint-url http://localhost:4566 iam get-role --role-name s19-web-dev-ec2-role

aws: [ERROR]: An error occurred (NoSuchEntity) when calling the GetRole operation: Role s19-web-dev-ec2-role not found

$ echo "resources in state: $(terraform state list | wc -l | tr -d " ")"
resources in state: 0
```

The VPC, subnet, Internet Gateway and security group no longer exist. The bucket returns `404`, and the IAM role returns `NoSuchEntity`. The instance shows `terminated`. AWS (and Moto) keeps a terminated instance visible for a short time, but it is deleted and has no cost. The state has 0 resources.

## Terraform commands used

| Command | Purpose |
|---------|---------|
| `terraform init` | Download the provider and create the lock file |
| `terraform fmt -check` | Make sure that the files use the standard format |
| `terraform validate` | Examine syntax and references |
| `terraform providers` | Show the providers that the configuration needs |
| `terraform plan -out=tfplan` | Show and save the changes |
| `terraform graph` | Print the dependency graph (DOT format) |
| `terraform apply tfplan` | Do the saved plan |
| `terraform plan -detailed-exitcode` | Exit code 0 = no changes, 2 = changes (drift) |
| `terraform state list` | List the resources in the state |
| `terraform state show <address>` | Show all attributes of one resource |
| `terraform output` | Print the outputs |
| `terraform plan -destroy` | Preview the removal |
| `terraform destroy` | Remove all resources |

## Run on real AWS

The emulator settings are only in [providers.tf](terraform-project/providers.tf).

1. Remove the lines between `# EMULATOR START` and `# EMULATOR END` (the test keys, the `skip_*` settings, `s3_use_path_style` and the `endpoints` block).
2. Run `aws configure` (or `aws configure sso`) with your own account.
3. In `terraform.tfvars`, change `ami_id` to an AMI from your region. For example, read the SSM parameter `/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64`.
4. In `terraform.tfvars`, change `bucket_name` to a globally unique name and `allowed_ssh_cidr` to your own public IP with `/32`.
5. Run `terraform init`, `terraform plan` and `terraform apply`.
6. Open the `web_url` output in a browser. The nginx page appears after the instance boots.
7. Run `terraform destroy` when you finish. A running instance and its public IPv4 address cost money.

## Cleanup

1. I removed all resources with `terraform destroy` and checked with the AWS CLI that they were gone.
2. I removed `.terraform/`, `terraform.tfstate`, `terraform.tfstate.backup` and `tfplan`. The `.gitignore` keeps these files out of Git.
3. I stopped and removed the `moto` container.
