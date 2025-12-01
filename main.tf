provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "mac_instance" {
  ami           = "ami-093a7f5fbae13ff67" # mac2 M1 AMI for us-east-1
  instance_type = "mac1.metal"
  key_name      = "Lab_env_Mac"

  user_data = file("${path.module}/scripts/install_macos_tools.sh")

  tags = {
    Name      = "lab-env-ec2-macos"
    Project   = "terraform-mac-automation"
    ManagedBy = "Terraform"
    OS        = "macOS"
  }
}
