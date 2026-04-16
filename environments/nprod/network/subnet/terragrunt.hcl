include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "subnet_common" {
  path   = find_in_parent_folders("_envcommon/subnet.hcl")
  expose = true
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "vpc-00000000000000000"
  }

  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = merge(
  include.subnet_common.inputs,
  {
    vpc_id = dependency.vpc.outputs.vpc_id
    subnets = [
      {
        name                    = "nprod-public-a"
        cidr_block              = "10.20.1.0/24"
        availability_zone       = "eu-central-1a"
        map_public_ip_on_launch = true
      },
      {
        name                    = "nprod-private-a"
        cidr_block              = "10.20.11.0/24"
        availability_zone       = "eu-central-1a"
        map_public_ip_on_launch = false
      }
    ]
  }
)
