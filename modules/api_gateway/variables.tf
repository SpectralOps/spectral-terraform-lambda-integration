variable "lambda_function_arn" {
  type        = string
  description = "The ARN of the Lambda function."
}

variable "environment" {
  type        = string
  description = "The target environment name for deployment."
}

variable "resource_name_pattern" {
  type        = string
  description = "A common resource name created by pattern."
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

variable "integration_type" {
  type        = string
  description = "Spectral integration type (A unique phrase describing the integration) - Available values: `terraform`."
}

variable "function_name" {
  type        = string
  description = "The name of the function the API would trigger upon request"
}