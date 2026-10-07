aws_region         = "us-east-1"
project_name       = "s19-web"
environment        = "dev"
vpc_cidr           = "10.20.0.0/16"
public_subnet_cidr = "10.20.1.0/24"
allowed_ssh_cidr   = "203.0.113.10/32" # Documentation IP (RFC 5737). Use your own public IP.
instance_type      = "t3.micro"
bucket_name        = "kartavya-s19-web-assets"

# Amazon Linux 2 AMI from the emulator image list ("aws ec2 describe-images").
# On real AWS, use an AMI ID that exists in your region.
ami_id = "ami-05448533fbe614dce"
