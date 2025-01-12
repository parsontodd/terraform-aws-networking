# Overview
This module manages the creation of AWS VPCs and subnets, allowing the user to create both private and public subnets.

## Details
The module 
1. Creates a VPC with a given CIDR block
2. Allow the user to provide the configuration for multiple subnets:
    2.1 The user provides the CIDR block(s)
    2.2 The user can mark a subnet as public or private
        2.2.1 If at least one subnet is public, deploy an internet gateway
        2.2.2 Associate the public subnet with a public route table
    2.3 The user provides the AWS availability zone

### Example
Use the following Terraform to use the module to create 2 subnets - 1 private and 1 public. More examples can be found in the examples directory in this repo.

```
module "vpc" {
  source = "./modules/networking"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "your_vpc_name"
  }

  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "us-east-1a"
    }

    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      public     = true
      az         = "us-east-1a"
    }
  }
}
```
        
