terraform {
  source = "../../../modules/s3"
}

locals {
  env  = "sandbox"
  name = "cm-${local.env}-bucket"
}

inputs = {
  bucket_name        = local.name
  versioning_enabled = true
  tags = {
    Environment = local.env
    ManagedBy   = "terragrunt"
  }
}
