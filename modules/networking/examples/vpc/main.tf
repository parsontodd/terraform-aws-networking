module "vpc" {
  source = "./modules/networking"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "parson"
  }

  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "us-east-1a"
    }

    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      # Public subnets are indicated by setting "public" option to true. This will automatically create an Internet Gateway, routing table, and associate the subnet with the routing table.
      public     = true
      az         = "us-east-1a"
    }
  }
}