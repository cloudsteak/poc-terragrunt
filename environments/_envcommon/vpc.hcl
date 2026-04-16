locals {
  env_config  = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.env_config.locals.environment
}

terraform {
  source = "${get_repo_root()}/modules/network/vpc"
}

inputs = {
  name = "${local.environment}-vpc"

  tags = {
    Environment = local.environment
    Component   = "vpc"
    ManagedBy   = "Terragrunt"
  }
}
