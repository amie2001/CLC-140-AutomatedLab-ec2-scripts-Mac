provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "mac_instance" {
  ami           = "ami-0c4d1b01002bc5424" # mac2 M1 AMI for us-east-1
  instance_type = "mac2.metal"
  tenancy           = "host"                        # 🔥 MANDATORY
  host_id           = aws_ec2_host.mac_host.id
  key_name      = "Lab_env_Mac(test)"

  user_data = file("${path.module}/scripts/install_macos_tools.sh")

  tags = {
    Name      = "lab-env-ec2-macos"
    Project   = "terraform-mac-automation"
    ManagedBy = "Terraform"
    OS        = "macOS"
  }
}
