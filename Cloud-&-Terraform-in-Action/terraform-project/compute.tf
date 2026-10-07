# EC2 web server in the public subnet.
# NOTE: On the local emulator, this instance is only a record. No virtual machine starts.
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2.name

  # On real AWS, this script installs and starts nginx at first boot.
  user_data = <<-EOT
    #!/bin/bash
    yum install -y nginx
    echo "<h1>Session 19 - deployed with Terraform</h1>" > /usr/share/nginx/html/index.html
    systemctl enable --now nginx
  EOT

  # Require IMDSv2 tokens for the instance metadata service.
  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  # Explicit dependency: the user_data script needs internet access at first boot.
  # The instance has no attribute that refers to the route table association,
  # so Terraform cannot see this dependency. depends_on tells Terraform about it.
  depends_on = [aws_route_table_association.public]

  tags = {
    Name = "${local.name_prefix}-web"
  }
}
