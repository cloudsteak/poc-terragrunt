locals {
  environment       = "prod"
  aws_region        = "eu-central-1"
  aws_account_id    = get_env("TG_AWS_ACCOUNT_ID_ACCOUNT2")
  state_kms_key_arn = get_env("TG_STATE_KMS_KEY_ARN_PROD")
}
