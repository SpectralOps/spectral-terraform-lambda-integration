provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.account_id]
}