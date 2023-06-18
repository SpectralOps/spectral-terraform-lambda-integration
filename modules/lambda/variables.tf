variable "logs_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group."
}

variable "env_vars" {
  description = "Extendable object contains all required environment variables required for the integration."
  type        = map(string)
}

variable "environment" {
  type        = string
  description = "The target environment name for deployment."
}

variable "resource_name_pattern" {
  type        = string
  description = "A common resource name created by pattern."
}

variable "should_write_logs" {
  type        = bool
  description = "Specifies if Lambda should have CloudWatch a dedicated logs group."
  default     = false
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

variable "timeout" {
  type        = number
  description = "Amount of time your Lambda Function has to run in seconds. Defaults to 300."
  default     = 300
}

variable "memory_size" {
  type        = number
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 1024."
  default     = 1024
}

variable "publish" {
  type        = bool
  description = "Whether to publish creation/change as new Lambda Function Version."
  default     = false
}

variable "secrets_arns" {
  description = "List of secrets associated with the lambda"
  type        = list(string)
  default     = []
}

variable "store_secret_in_secrets_manager" {
  description = "Whether to store your secrets in secrets manager, default is false"
  type        = bool
}

variable "lambda_source_code_filename" {
  type        = string
  description = "The lambda source code filename"
}

variable "role_arn" {
  type        = string
  description = "The lambda source code filename"
}

variable "lambda_handler" {
  type        = string
  description = "The handler of the handler"
  default     = "handler.app"
}