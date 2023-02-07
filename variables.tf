variable "integration_type" {
  type        = string
  description = "Spectral integration type (A unique phrase describing the integration) - Available values: `terraform`."
}

variable "environment" {
  type        = string
  description = "The target environment name for deployment."
  default     = "prod"
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

# Lambda variables

variable "env_vars" {
  type        = map(string)
  description = "Extendable object contains all required environment variables required for the integration."
  default = {
    SPECTRAL_DSN = ""
    CHECK_POLICY = "Fail on errors only"
  }
}

variable "lambda_logs_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group."
  default     = 30
}

variable "lambda_enable_logs" {
  type        = bool
  description = "Specifies if Lambda should have CloudWatch a dedicated logs group."
  default     = false
}

variable "lambda_function_timeout" {
  type        = number
  description = "Amount of time your Lambda Function has to run in seconds."
  default     = 300
}

variable "lambda_function_memory_size" {
  type        = number
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 1024."
  default     = 1024
}

variable "lambda_publish" {
  type        = bool
  description = "Whether to publish creation/change as new Lambda Function Version."
  default     = false
}