terraform {
  backend "s3" {
    bucket = "automated-lab-ec2-instances"
    key    = "AutomatedLab-ec2-state-mac/terraform.tfstate"
    region = "us-west-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

############################################
# MAC DEDICATED HOST (MANDATORY)
############################################
resource "aws_ec2_host" "mac_host" {
  instance_type     = "mac2-m1.metal"
  availability_zone = "us-west-2a"
  auto_placement    = "on"
}

############################################
# MAC EC2 INSTANCE
############################################
resource "aws_instance" "mac_ec2" {
  ami                    = "ami-0f8c45225ea6a7598"
  instance_type          = "mac2-m1.metal"
  host_id                = aws_ec2_host.mac_host.id
  key_name               = "Lab_env_Mac"

  user_data = file("${path.module}/scripts/mac_install_apps.sh")

  tags = {
    Name      = "lab-env-ec2-macos"
    Project   = "terraform-mac-automation"
    ManagedBy = "Terraform"
    OS        = "macOS"
  }
}
