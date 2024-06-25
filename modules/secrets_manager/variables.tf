variable "integration_type" {
  description = "Integration type to create secrets for"
  type        = string
}

variable "secrets_names" {
  description = "Names of secrets to create"
  type        = list(string)
}