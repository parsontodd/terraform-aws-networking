variable "vpc_config" {
  description = "Contains the VPC configuration: the required CIDR block (cidr_block) and name of the VPC (name)"

  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block configuration must contain a valid CIDR block."
  }
}

variable "subnet_config" {
  description = <<EOT
  Accepts a map of subnet configurations. Each subnet configuration should contain:

  cidr_block  : The CIDR block of your subnet
  public      : Whether the subnet should be public or not (defaults to false)
  az          : The availability zone where to deply the subnet.
  EOT
  type = map(object({
    cidr_block = string
    public     = optional(bool, false)
    az         = string
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "The cidr_block config option must contain a valid CIDR block."
  }
}