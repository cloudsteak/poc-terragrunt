#!/usr/bin/env bash
set -euo pipefail

# Copy this file to scripts/set-env.sh and replace placeholders.
# Never commit scripts/set-env.sh with real values.

export TG_AWS_ACCOUNT_ID_ACCOUNT1="<account-id-1>"
export TG_AWS_ACCOUNT_ID_ACCOUNT2="<account-id-2>"

export TG_STATE_KMS_KEY_ARN_PLAYGROUND="arn:aws:kms:eu-central-1:<account-id-1>:key/<kms-key-id>"
export TG_STATE_KMS_KEY_ARN_NPROD="arn:aws:kms:eu-central-1:<account-id-1>:key/<kms-key-id>"
export TG_STATE_KMS_KEY_ARN_PRE_PROD="arn:aws:kms:eu-central-1:<account-id-2>:key/<kms-key-id>"
export TG_STATE_KMS_KEY_ARN_PROD="arn:aws:kms:eu-central-1:<account-id-2>:key/<kms-key-id>"

printf 'Terragrunt environment variables are set for this shell.\n'
