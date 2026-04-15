locals {
  env_config  = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.env_config.locals.environment
}

terraform {
  source = "${get_repo_root()}/modules/network/subnet"
}

inputs = {
  tags = {
    Environment = local.environment
    Component   = "subnet"
    ManagedBy   = "Terragrunt"
  }
}
