variable "store_secret_in_secrets_manager" {
  description = "Whether to store your secrets in secrets manager, default is false"
  type        = bool
}

variable "secrets_arns" {
  description = "List of secrets associated with the lambda"
  type        = list(string)
  default     = []
}

variable "blacklist_object_arn" {
  description = "Arn of the blacklist file"
  type        = string
  default     = null
}

variable "global_tags" {
  type        = map(string)
  description = "A list of tags to apply on all newly created resources."
  default = {
    BusinessUnit = "Spectral"
  }
}

variable "tags" {
  type        = map(map(string))
  description = "A collection of tags grouped by key representing it's target resource."
  default = {
    iam         = {}
    lambda      = {}
    api_gateway = {}
  }
}

variable "role_name" {
  type        = string
  description = "The name of the role"
}

variable "multiple_lambda_integration" {
  type        = bool
  description = "Is current integration structure contains two lambdas"
}