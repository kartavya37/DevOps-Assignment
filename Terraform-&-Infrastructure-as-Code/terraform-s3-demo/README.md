# Terraform S3 Demo

This project creates one Amazon S3 bucket with Terraform. It shows the full Terraform workflow: `init`, `fmt`, `validate`, `plan`, `apply`, `show`, `output` and `destroy`.

> **Local AWS emulator.** I do not have an AWS account. All commands in this document ran against [Moto server](https://github.com/getmoto/moto), a free local AWS emulator, in a Docker container on `http://localhost:4566`. The bucket existed only inside the emulator. The account ID `123456789012` in the output is the Moto test account, not a real AWS account. The Terraform code is the same code that you use for real AWS. Only the emulator block in `provider.tf` is different. Refer to [Run on real AWS](#run-on-real-aws).

## Project structure

```text
terraform-s3-demo/
├── main.tf               # S3 bucket, versioning, encryption, public access block
├── variables.tf          # input variables with types, defaults and validation
├── outputs.tf            # values that Terraform prints after apply
├── provider.tf           # Terraform version, AWS provider version, provider settings
├── terraform.tfvars      # values for the variables
├── README.md             # this document
├── .gitignore            # keeps .terraform/ and state files out of Git
└── .terraform.lock.hcl   # exact provider version (Terraform makes this file at init)
```

| File | Purpose |
|------|---------|
| [provider.tf](provider.tf) | The `terraform` block pins Terraform `>= 1.6.0` and the AWS provider `~> 6.0`. The `provider "aws"` block sets the region, the emulator endpoints and `default_tags`. |
| [variables.tf](variables.tf) | Four variables: `aws_region`, `bucket_name`, `environment`, `versioning_enabled`. `bucket_name` and `environment` have `validation` rules. |
| [terraform.tfvars](terraform.tfvars) | Values for the variables. Terraform loads this file automatically. |
| [main.tf](main.tf) | Four resources: `aws_s3_bucket`, `aws_s3_bucket_versioning`, `aws_s3_bucket_server_side_encryption_configuration`, `aws_s3_bucket_public_access_block`. |
| [outputs.tf](outputs.tf) | Four outputs: bucket name, ARN, region, and versioning status. |

## Architecture

```mermaid
flowchart LR
    TFV[terraform.tfvars] --> VAR[variables.tf]
    VAR --> MAIN[main.tf]
    PROV["provider.tf<br/>AWS provider ~> 6.0"] --> MAIN
    MAIN --> B[aws_s3_bucket.demo]
    B --> V[aws_s3_bucket_versioning]
    B --> E[aws_s3_bucket_server_side_encryption_configuration]
    B --> P[aws_s3_bucket_public_access_block]
    B --> OUT[outputs.tf]
    subgraph EMU["Moto server - localhost:4566"]
      S3[(S3 bucket<br/>kartavya-s18-terraform-demo)]
    end
    B -. API calls .-> S3
```

The three settings resources refer to `aws_s3_bucket.demo.id`. Because of this reference, Terraform creates the bucket first. Then it creates the three settings resources in parallel.

## Why these settings

- **Versioning:** S3 keeps every version of an object. You can recover an object that someone deleted or overwrote.
- **Encryption (SSE-S3, AES-256):** S3 encrypts every new object at rest with keys that S3 manages. AWS applies SSE-S3 to new objects by default since January 2023. The resource makes the setting visible in code.
- **Public access block:** All four settings are `true`. Nobody can make the bucket or its objects public with an ACL or a bucket policy.
- **Tags:** The resource sets `Name` and `Environment`. The provider adds `ManagedBy` and `Project` to every resource through `default_tags`.
- **`force_destroy = true`:** `terraform destroy` can remove the bucket even if it contains objects. Use this only for demo buckets.

## Prerequisites

1. Install Terraform 1.6 or later. I used Terraform v1.16.4.
2. Install the AWS CLI v2. I used aws-cli 2.36.29.
3. Start the emulator in Docker.

```bash
docker run -d --name moto -p 4566:5000 motoserver/moto
```

**WARNING:** Do not let Terraform or the AWS CLI use real credentials by accident. Export dummy credentials in every shell before you run the commands below.

```bash
export AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test AWS_DEFAULT_REGION=us-east-1
export AWS_SHARED_CREDENTIALS_FILE=/dev/null AWS_CONFIG_FILE=/dev/null
unset AWS_PROFILE
```

For the AWS CLI, always add `--endpoint-url http://localhost:4566`. Without this option, the CLI sends the request to real AWS.

## Step 1: terraform init

1. Go to the project folder.
2. Run `terraform init`.

![terraform init](../screenshots/01-terraform-init.png)

```console
$ terraform init -no-color
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 6.0"...
- Installing hashicorp/aws v6.67.0...
- Installed hashicorp/aws v6.67.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

`init` downloads the AWS provider plugin (v6.67.0) into `.terraform/`. It also writes `.terraform.lock.hcl` with the exact provider version and checksums. Commit the lock file. Do not commit `.terraform/`.

## Step 2: terraform fmt and terraform validate

1. Run `terraform fmt -check -diff` to find files with a wrong format.
2. Run `terraform fmt` to correct the format.
3. Run `terraform validate` to examine the syntax and the references.

![terraform fmt and validate](../screenshots/02-terraform-fmt-validate.png)

```console
$ terraform fmt -check -diff; echo "fmt exit code: $?"
fmt exit code: 0

$ terraform fmt

$ terraform validate -no-color
Success! The configuration is valid.
```

`fmt -check` returned exit code 0, so all files already had the standard format. `fmt` printed no file names because it changed no files. `validate` makes sure that the configuration is correct. It does not connect to AWS.

## Step 3: terraform plan

1. Run `terraform plan -out=tfplan`.
2. Read the plan before you apply it.

![terraform plan, top part](../screenshots/03a-terraform-plan-top.png)

![terraform plan, bottom part](../screenshots/03b-terraform-plan-bottom.png)

Full output:

```console
$ terraform plan -no-color -out=tfplan

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.demo will be created
  + resource "aws_s3_bucket" "demo" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "kartavya-s18-terraform-demo"
      + bucket_domain_name          = (known after apply)
      + bucket_namespace            = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_region               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = true
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = "us-east-1"
      + request_payer               = (known after apply)
      + tags                        = {
          + "Environment" = "dev"
          + "Name"        = "kartavya-s18-terraform-demo"
        }
      + tags_all                    = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "kartavya-s18-terraform-demo"
          + "Project"     = "Session18"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule (known after apply)

      + grant (known after apply)

      + lifecycle_rule (known after apply)

      + logging (known after apply)

      + object_lock_configuration (known after apply)

      + replication_configuration (known after apply)

      + server_side_encryption_configuration (known after apply)

      + versioning (known after apply)

      + website (known after apply)
    }

  # aws_s3_bucket_public_access_block.demo will be created
  + resource "aws_s3_bucket_public_access_block" "demo" {
      + block_public_acls       = true
      + block_public_policy     = true
      + bucket                  = (known after apply)
      + id                      = (known after apply)
      + ignore_public_acls      = true
      + region                  = "us-east-1"
      + restrict_public_buckets = true
    }

  # aws_s3_bucket_server_side_encryption_configuration.demo will be created
  + resource "aws_s3_bucket_server_side_encryption_configuration" "demo" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "us-east-1"

      + rule {
          + blocked_encryption_types = (known after apply)
          + bucket_key_enabled       = (known after apply)

          + apply_server_side_encryption_by_default {
              + kms_master_key_id = (known after apply)
              + sse_algorithm     = "AES256"
            }
        }
    }

  # aws_s3_bucket_versioning.demo will be created
  + resource "aws_s3_bucket_versioning" "demo" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "us-east-1"

      + versioning_configuration {
          + mfa_delete = (known after apply)
          + status     = "Enabled"
        }
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bucket_arn        = (known after apply)
  + bucket_name       = "kartavya-s18-terraform-demo"
  + bucket_region     = "us-east-1"
  + versioning_status = "Enabled"

─────────────────────────────────────────────────────────────────────────────

Saved the plan to: tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "tfplan"
```

The `+` symbol means "create". The plan has 4 resources to add. Values such as `arn` are `(known after apply)` because AWS sets them when it creates the bucket. `tags_all` shows the resource tags plus the two `default_tags` from the provider. The `-out=tfplan` option saves the plan, so `apply` does exactly these actions.

## Step 4: terraform apply

1. Run `terraform apply tfplan`.

![terraform apply](../screenshots/04-terraform-apply.png)

```console
$ terraform apply -no-color tfplan
aws_s3_bucket.demo: Creating...
aws_s3_bucket.demo: Creation complete after 0s [id=kartavya-s18-terraform-demo]
aws_s3_bucket_public_access_block.demo: Creating...
aws_s3_bucket_versioning.demo: Creating...
aws_s3_bucket_server_side_encryption_configuration.demo: Creating...
aws_s3_bucket_public_access_block.demo: Creation complete after 0s [id=kartavya-s18-terraform-demo]
aws_s3_bucket_server_side_encryption_configuration.demo: Creation complete after 0s [id=kartavya-s18-terraform-demo]
aws_s3_bucket_versioning.demo: Creation complete after 2s [id=kartavya-s18-terraform-demo]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

bucket_arn = "arn:aws:s3:::kartavya-s18-terraform-demo"
bucket_name = "kartavya-s18-terraform-demo"
bucket_region = "us-east-1"
versioning_status = "Enabled"
```

Terraform created the bucket first. Then it created the other three resources in parallel, because each one depends only on the bucket. A saved plan does not ask for confirmation. If you run `terraform apply` without a plan file, Terraform shows the plan and asks you to type `yes`.

### Emulator limitation: bucket tags

After the first apply, `terraform plan` showed a change for the bucket tags. AWS provider v6 sends the tags inside the `CreateBucket` request. Moto ignores tags in that request, so the bucket had no tags. A second `terraform apply` sent the tags with a separate `PutBucketTagging` call. This is drift: the real resource was different from the configuration, and Terraform corrected it. On real AWS, the first apply sets the tags.

![second apply sets the tags](../screenshots/04b-tag-drift-fix.png)

```console
$ terraform apply -no-color -auto-approve | tail -n 32
Terraform will perform the following actions:

  # aws_s3_bucket.demo will be updated in-place
  ~ resource "aws_s3_bucket" "demo" {
        id                          = "kartavya-s18-terraform-demo"
      ~ tags                        = {
          + "Environment" = "dev"
          + "Name"        = "kartavya-s18-terraform-demo"
        }
      ~ tags_all                    = {
          + "Environment" = "dev"
          + "ManagedBy"   = "Terraform"
          + "Name"        = "kartavya-s18-terraform-demo"
          + "Project"     = "Session18"
        }
        # (14 unchanged attributes hidden)

        # (3 unchanged blocks hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.
aws_s3_bucket.demo: Modifying... [id=kartavya-s18-terraform-demo]
aws_s3_bucket.demo: Modifications complete after 0s [id=kartavya-s18-terraform-demo]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

bucket_arn = "arn:aws:s3:::kartavya-s18-terraform-demo"
bucket_name = "kartavya-s18-terraform-demo"
bucket_region = "us-east-1"
versioning_status = "Enabled"
```

After this apply, `terraform plan -detailed-exitcode` returned exit code 0 with "No changes. Your infrastructure matches the configuration."

## Step 5: terraform show

1. Run `terraform show` to read the current state in a human-readable format.

![terraform show, bucket](../screenshots/05a-terraform-show-bucket.png)

![terraform show, settings resources](../screenshots/05b-terraform-show-settings.png)

```console
$ terraform show -no-color
# aws_s3_bucket.demo:
resource "aws_s3_bucket" "demo" {
    acceleration_status         = null
    arn                         = "arn:aws:s3:::kartavya-s18-terraform-demo"
    bucket                      = "kartavya-s18-terraform-demo"
    bucket_domain_name          = "kartavya-s18-terraform-demo.s3.amazonaws.com"
    bucket_namespace            = "global"
    bucket_prefix               = null
    bucket_region               = "us-east-1"
    bucket_regional_domain_name = "kartavya-s18-terraform-demo.s3.us-east-1.amazonaws.com"
    force_destroy               = true
    hosted_zone_id              = "Z3AQBSTGFYJSTF"
    id                          = "kartavya-s18-terraform-demo"
    object_lock_enabled         = false
    policy                      = null
    region                      = "us-east-1"
    request_payer               = null
    tags                        = {
        "Environment" = "dev"
        "Name"        = "kartavya-s18-terraform-demo"
    }
    tags_all                    = {
        "Environment" = "dev"
        "ManagedBy"   = "Terraform"
        "Name"        = "kartavya-s18-terraform-demo"
        "Project"     = "Session18"
    }

    grant {
        id          = "75aa57f09aa0c8caeab4f8c24e99d10f8e7faeebf76c078efc7c6caea54ba06a"
        permissions = [
            "FULL_CONTROL",
        ]
        type        = "CanonicalUser"
        uri         = null
    }

    server_side_encryption_configuration {
        rule {
            bucket_key_enabled = false

            apply_server_side_encryption_by_default {
                kms_master_key_id = null
                sse_algorithm     = "AES256"
            }
        }
    }

    versioning {
        enabled    = true
        mfa_delete = false
    }
}

# aws_s3_bucket_public_access_block.demo:
resource "aws_s3_bucket_public_access_block" "demo" {
    block_public_acls       = true
    block_public_policy     = true
    bucket                  = "kartavya-s18-terraform-demo"
    id                      = "kartavya-s18-terraform-demo"
    ignore_public_acls      = true
    region                  = "us-east-1"
    restrict_public_buckets = true
}

# aws_s3_bucket_server_side_encryption_configuration.demo:
resource "aws_s3_bucket_server_side_encryption_configuration" "demo" {
    bucket                = "kartavya-s18-terraform-demo"
    expected_bucket_owner = null
    id                    = "kartavya-s18-terraform-demo"
    region                = "us-east-1"

    rule {
        blocked_encryption_types = []
        bucket_key_enabled       = false

        apply_server_side_encryption_by_default {
            kms_master_key_id = null
            sse_algorithm     = "AES256"
        }
    }
}

# aws_s3_bucket_versioning.demo:
resource "aws_s3_bucket_versioning" "demo" {
    bucket                = "kartavya-s18-terraform-demo"
    expected_bucket_owner = null
    id                    = "kartavya-s18-terraform-demo"
    region                = "us-east-1"

    versioning_configuration {
        mfa_delete = "Disabled"
        status     = "Enabled"
    }
}


Outputs:

bucket_arn = "arn:aws:s3:::kartavya-s18-terraform-demo"
bucket_name = "kartavya-s18-terraform-demo"
bucket_region = "us-east-1"
versioning_status = "Enabled"
```

`terraform show` reads `terraform.tfstate`. It shows every attribute that Terraform knows for each resource: the ARN, the encryption rule (`AES256`), versioning `Enabled`, and the four public access block settings.

## Step 6: terraform output

1. Run `terraform output` to print all outputs.
2. Run `terraform output -raw <name>` to print one value without quotes. Scripts can use this value.
3. Run `terraform state list` to list the resources in the state.

![terraform output](../screenshots/06-terraform-output-state.png)

```console
$ terraform output
bucket_arn = "arn:aws:s3:::kartavya-s18-terraform-demo"
bucket_name = "kartavya-s18-terraform-demo"
bucket_region = "us-east-1"
versioning_status = "Enabled"

$ terraform output -raw bucket_arn; echo
arn:aws:s3:::kartavya-s18-terraform-demo

$ terraform state list
aws_s3_bucket.demo
aws_s3_bucket_public_access_block.demo
aws_s3_bucket_server_side_encryption_configuration.demo
aws_s3_bucket_versioning.demo
```

## Step 7: Make sure that the bucket exists (AWS CLI)

1. Run the AWS CLI with `--endpoint-url http://localhost:4566`.
2. Examine the bucket, the versioning, the encryption, the public access block and the tags.

![aws cli bucket exists](../screenshots/07a-aws-cli-bucket-exists.png)

```console
$ aws --endpoint-url http://localhost:4566 sts get-caller-identity --output text
123456789012	arn:aws:sts::123456789012:user/moto	AKIAIOSFODNN7EXAMPLE

$ aws --endpoint-url http://localhost:4566 s3 ls
2026-10-07 17:03:28 kartavya-s18-terraform-demo

$ aws --endpoint-url http://localhost:4566 s3api get-bucket-versioning --bucket kartavya-s18-terraform-demo
{
    "Status": "Enabled"
}

$ aws --endpoint-url http://localhost:4566 s3api get-bucket-encryption --bucket kartavya-s18-terraform-demo --query "ServerSideEncryptionConfiguration.Rules[0]"
{
    "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
    },
    "BucketKeyEnabled": false
}
```

`sts get-caller-identity` returns the Moto test account `123456789012`. This proves that the CLI talks to the emulator, not to a real AWS account.

![aws cli bucket settings](../screenshots/07b-aws-cli-bucket-settings.png)

```console
$ aws --endpoint-url http://localhost:4566 s3api get-public-access-block --bucket kartavya-s18-terraform-demo
{
    "PublicAccessBlockConfiguration": {
        "BlockPublicAcls": true,
        "IgnorePublicAcls": true,
        "BlockPublicPolicy": true,
        "RestrictPublicBuckets": true
    }
}

$ aws --endpoint-url http://localhost:4566 s3api get-bucket-tagging --bucket kartavya-s18-terraform-demo --output table
--------------------------------------------------
|                GetBucketTagging                |
+------------------------------------------------+
||                    TagSet                    ||
|+--------------+-------------------------------+|
||      Key     |             Value             ||
|+--------------+-------------------------------+|
||  ManagedBy   |  Terraform                    ||
||  Name        |  kartavya-s18-terraform-demo  ||
||  Project     |  Session18                    ||
||  Environment |  dev                          ||
|+--------------+-------------------------------+|

$ echo "hello from terraform" > /tmp/s18-hello.txt && aws --endpoint-url http://localhost:4566 s3 cp /tmp/s18-hello.txt s3://kartavya-s18-terraform-demo/hello.txt
Completed 21 Bytes/21 Bytes (1.3 KiB/s) with 1 file(s) remaining
upload: ../../../../../../../../../tmp/s18-hello.txt to s3://kartavya-s18-terraform-demo/hello.txt

$ aws --endpoint-url http://localhost:4566 s3 ls s3://kartavya-s18-terraform-demo/
2026-10-07 17:04:48         21 hello.txt
```

Versioning test: upload the same key again and list the versions.

![aws cli object versions](../screenshots/07c-aws-cli-object-versions.png)

```console
$ echo "hello again (version 2)" | aws --endpoint-url http://localhost:4566 s3 cp - s3://kartavya-s18-terraform-demo/hello.txt

$ aws --endpoint-url http://localhost:4566 s3api list-object-versions --bucket kartavya-s18-terraform-demo --query "Versions[].[Key,VersionId,IsLatest,Size]" --output table
----------------------------------------------------------------------
|                         ListObjectVersions                         |
+-----------+----------------------------------------+--------+------+
|  hello.txt|  7c11b3cb-55b0-45e3-9f19-9974f03cefe7  |  True  |  24  |
|  hello.txt|  9eed0823-3c4c-4b9d-b421-bb9fda9bbc0d  |  False |  21  |
+-----------+----------------------------------------+--------+------+
```

S3 kept both versions of `hello.txt`. The new version has `IsLatest = True`. The old version is still available.

## Step 8: terraform destroy

1. Run `terraform destroy`.
2. Read the list of resources that Terraform will remove.
3. Type `yes` to confirm.

**CAUTION:** `terraform destroy` removes all resources in the state. There is no undo. On real AWS, the bucket and all its objects are lost.

![terraform destroy](../screenshots/08-terraform-destroy.png)

```console
$ echo yes | terraform destroy -no-color | tail -n 26
        }
    }

Plan: 0 to add, 0 to change, 4 to destroy.

Changes to Outputs:
  - bucket_arn        = "arn:aws:s3:::kartavya-s18-terraform-demo" -> null
  - bucket_name       = "kartavya-s18-terraform-demo" -> null
  - bucket_region     = "us-east-1" -> null
  - versioning_status = "Enabled" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: 
aws_s3_bucket_versioning.demo: Destroying... [id=kartavya-s18-terraform-demo]
aws_s3_bucket_public_access_block.demo: Destroying... [id=kartavya-s18-terraform-demo]
aws_s3_bucket_server_side_encryption_configuration.demo: Destroying... [id=kartavya-s18-terraform-demo]
aws_s3_bucket_versioning.demo: Destruction complete after 0s
aws_s3_bucket_server_side_encryption_configuration.demo: Destruction complete after 0s
aws_s3_bucket_public_access_block.demo: Destruction complete after 0s
aws_s3_bucket.demo: Destroying... [id=kartavya-s18-terraform-demo]
aws_s3_bucket.demo: Destruction complete after 0s

Destroy complete! Resources: 4 destroyed.
```

Terraform removed the three settings resources first and the bucket last. This is the reverse of the create order. `force_destroy = true` let Terraform remove the bucket although it contained two object versions.

## Step 9: Make sure that the bucket no longer exists

![aws cli bucket gone](../screenshots/09-aws-cli-bucket-gone.png)

```console
$ aws --endpoint-url http://localhost:4566 s3 ls; echo "bucket count: $(aws --endpoint-url http://localhost:4566 s3api list-buckets --query "length(Buckets)")"
bucket count: 0

$ aws --endpoint-url http://localhost:4566 s3api head-bucket --bucket kartavya-s18-terraform-demo

aws: [ERROR]: An error occurred (404) when calling the HeadBucket operation: Not Found

$ terraform state list; echo "resources in state: $(terraform state list | wc -l | tr -d " ")"
resources in state: 0

$ terraform output
╷
│ Warning: No outputs found
│ 
│ The state file either has no outputs defined, or all the defined outputs
│ are empty. Please define an output in your configuration with the `output`
│ keyword and run `terraform refresh` for it to become available. If you are
│ using interpolation, please verify the interpolated value is not empty. You
│ can use the `terraform console` command to assist.
╵
```

The emulator has 0 buckets. `head-bucket` returns `404 Not Found`. The state has 0 resources, so `terraform output` has no values.

## Command summary

| Command | What it does |
|---------|--------------|
| `terraform init` | Downloads providers, configures the backend, writes the lock file. |
| `terraform fmt` | Rewrites `.tf` files in the standard format. |
| `terraform validate` | Examines syntax, types and references. No API calls. |
| `terraform plan` | Compares the configuration with the state and the real resources. Shows the changes. |
| `terraform apply` | Does the changes and updates the state. |
| `terraform show` | Shows the state (or a saved plan) in a human-readable format. |
| `terraform output` | Prints the output values from the state. |
| `terraform destroy` | Removes all resources in the state. |

## Run on real AWS

The emulator settings are only in [provider.tf](provider.tf), between `# EMULATOR START` and `# EMULATOR END`.

1. Remove the lines between `# EMULATOR START` and `# EMULATOR END` (the test keys, the `skip_*` settings, `s3_use_path_style` and the `endpoints` block).
2. Run `aws configure` and enter the keys of an IAM user or use `aws configure sso`.
3. Change `bucket_name` in `terraform.tfvars` to a name that nobody else uses. S3 bucket names are globally unique.
4. Run `terraform init`, `terraform plan` and `terraform apply`.
5. Run `terraform destroy` when you finish, to stop all costs.
