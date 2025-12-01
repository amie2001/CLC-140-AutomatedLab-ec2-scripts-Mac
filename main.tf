provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "mac_instance" {
  ami           = "ami-0f8b0d25840c5e691" # mac2 M1 AMI Singapore
  instance_type = "mac2-m1.metal"
  key_name      = "Lab_env_Mac"

  user_data = file("${path.module}/scripts/install_macos_tools.sh")

  tags = {
    Name      = "lab-env-ec2-macos"
    Project   = "terraform-mac-automation"
    ManagedBy = "Terraform"
    OS        = "macOS"
  }
}
