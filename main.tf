provider "aws" {
  region = "ap-southeast-1"
}

#####################################################
# Dedicated Host for macOS (Mandatory for mac EC2)
#####################################################
resource "aws_ec2_host" "mac_host" {
  availability_zone = "ap-southeast-1a"
  instance_type     = "mac2.metal"   # REQUIRED for mac2 AMI
}

#####################################################
# macOS EC2 instance on that Dedicated Host
#####################################################
resource "aws_instance" "mac_instance" {
  ami               = "ami-0c4d1b01002bc5424"
  instance_type     = "mac2.metal"
  availability_zone = "ap-southeast-1a"

  tenancy           = "host"                      # MUST
  host_id           = aws_ec2_host.mac_host.id    # MUST

  key_name          = "Lab_env_Mac(test)"

  # macOS installation script
  user_data = file("${path.module}/scripts/install_macos_tools.sh")

  tags = {
    Name      = "lab-env-ec2-macos"
    Project   = "terraform-mac-automation"
    ManagedBy = "Terraform"
    OS        = "macOS"
  }
}
