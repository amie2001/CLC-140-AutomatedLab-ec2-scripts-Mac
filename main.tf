provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "automated-lab-ec2-instances"
    key    = "AutomatedLab-ec2-state-Mac/terraform.tfstate"
    region = "us-west-2"
  }
}

# Dedicated Mac Host (required)
resource "aws_ec2_host" "mac_host" {
  availability_zone = "us-west-2a"
  instance_type     = "mac1.metal"
}

# macOS EC2 instance
resource "aws_instance" "mac_instance" {
  ami                         = "ami-05c1e7b8b59cfe34f" # mac1 macOS Intel AMI
  instance_type               = "mac1.metal"
  availability_zone           = "us-west-2a"
  host_id                     = aws_ec2_host.mac_host.id
  key_name                    = "Lab_env_Mac"

  # macOS script
  user_data = file("${path.module}/scripts/install_macos_tools.sh")

  tags = {
    Name      = "lab-env-ec2-macos"
    Project   = "terraform-mac-automation"
    ManagedBy = "Terraform"
    OS        = "macOS"
  }
}
