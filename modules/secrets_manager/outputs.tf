output "secrets_arns" {
  value = coalesce(local.gitlab_secrets_arns)
}