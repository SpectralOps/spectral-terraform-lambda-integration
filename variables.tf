# General variables

variable "integration_type" {
  type        = string
  description = "Spectral integration type (A unique phrase describing the integration) - Available values: `github`, `terraform`, `jira` and `gitlab`"

  validation {
    condition     = contains(["github", "gitlab", "jira", "terraform"], var.integration_type)
    error_message = "Integration type is invalid"
  }
}

variable "lambda_source_code_path" {
  type        = string
  description = "Path to the lambda source code zip file"
  default     = null
}

variable "frontend_lambda_source_code_path" {
  type        = string
  description = "Path to the lambda source code zip file of the frontend lambda"
  default     = null
}

variable "backend_lambda_source_code_path" {
  type        = string
  description = "Path to the lambda source code zip file of the backend lambda"
  default     = null
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

variable "store_secret_in_secrets_manager" {
  type        = bool
  description = "Whether to store your secrets in secrets manager, default is false"
  default     = false

  validation {
    condition     = contains(["github", "gitlab"], var.integration_type)
    error_message = "Integration type is invalid"
  }
}

variable "resource_name_common_part" {
  type        = string
  description = "A common part for all resources created under the stack"
  default     = null
}

variable "secrets_names" {
  description = "Names of secrets to create"
  type        = list(string)
  default     = null
}

variable "gateway_api_integration_timeout_milliseconds" {
  description = "Timeout for the API Gateway to wait for lambda response"
  type        = number
  default     = 29000
}