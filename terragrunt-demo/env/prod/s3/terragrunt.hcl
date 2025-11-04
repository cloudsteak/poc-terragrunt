terraform {
  source = "../../../modules/s3"
}

locals {
  env  = "prod"
  name = "cm-${local.env}-bucket-2025"
}

inputs = {
  bucket_name        = local.name
  versioning_enabled = false
  tags = {
    Environment = local.env
    ManagedBy   = "terragrunt"
  }
}
