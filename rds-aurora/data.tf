# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones#attributes-reference
data "aws_availability_zones" "zones" {}


data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name = "name"
    # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type (first line of Amazon Linux AMI)
    values = ["amzn2-ami-kernel-5*-x86_64-gp2"]

    # Amazon Linux 2 AMI (HVM) - Kernel 4.14, SSD Volume Type (second line of Amazon Linux AMI)
    # values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}