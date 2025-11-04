terraform {
  source = "../../../modules/ec2"
}

locals {
  env         = "sandbox"
  name        = "cm-${local.env}-ec2"
  bucket_name = "cm-${local.env}-bucket"
  bucket_arn  = "arn:aws:s3:::${local.bucket_name}"
}

inputs = {
  instance_name     = local.name
  instance_count    = 1
  instance_type     = "t3.micro"
  attach_data_disk  = false
  s3_bucket_arn     = local.bucket_arn
  tags = {
    Environment = local.env
    ManagedBy   = "terragrunt"
  }
}
