# compute.tf
locals {
  instance_type = "t2.micro"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] #Owner is canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.instance_type
  subnet_id     = module.vpc.private_subnets["subnet_1"].subnet_id
  name          = "${local.project_name}-ec2"

  tags = merge(local.common_tags,
    {
      name = "${local.project_name}-ec2"
  })
}