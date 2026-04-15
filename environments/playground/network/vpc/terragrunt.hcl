include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "vpc_common" {
  path   = find_in_parent_folders("_envcommon/vpc.hcl")
  expose = true
}

inputs = merge(
  include.vpc_common.inputs,
  {
    cidr_block = "10.10.0.0/16"
  }
)
