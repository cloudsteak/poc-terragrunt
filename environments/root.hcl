locals {
  fallback_env_hcl  = "${get_repo_root()}/environments/playground/env.hcl"
  env_hcl_path      = try(find_in_parent_folders("env.hcl"), local.fallback_env_hcl)
  env_config        = read_terragrunt_config(local.env_hcl_path)
  environment       = local.env_config.locals.environment
  aws_region        = local.env_config.locals.aws_region
  aws_account_id    = local.env_config.locals.aws_account_id
  state_kms_key_arn = try(local.env_config.locals.state_kms_key_arn, "arn:aws:kms:${local.aws_region}:${local.aws_account_id}:key/00000000-0000-0000-0000-000000000000")

  state_bucket_name = "tg-state-${local.aws_account_id}-${local.aws_region}-${local.environment}"
  lock_table_name   = "tg-locks-${local.aws_account_id}-${local.environment}"
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = local.state_bucket_name
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = local.lock_table_name
    use_lockfile   = true

    bucket_sse_algorithm               = "aws:kms"
    bucket_sse_kms_key_id              = local.state_kms_key_arn
    skip_bucket_ssencryption           = false
    skip_bucket_versioning             = false
    skip_bucket_public_access_blocking = false
    skip_bucket_enforced_tls           = false

    s3_bucket_tags = {
      Environment = local.environment
      ManagedBy   = "Terragrunt"
      Compliance  = "2026-security-baseline"
    }

    dynamodb_table_tags = {
      Environment = local.environment
      ManagedBy   = "Terragrunt"
      Compliance  = "2026-security-baseline"
    }
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region              = "${local.aws_region}"
  allowed_account_ids = ["${local.aws_account_id}"]

  default_tags {
    tags = {
      Environment = "${local.environment}"
      ManagedBy   = "Terraform"
      Compliance  = "2026-security-baseline"
    }
  }
}
EOF
}
