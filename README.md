<img src="https://user-images.githubusercontent.com/44297242/188002580-ba0a6d59-8b1c-475e-bd61-192dd952194f.png" alt="drawing" style="width:400px;"/>

# spectral-lambda-integration

Terraform configuration used to create the required AWS resources for integrating between Spectral and external service providers.

## Requirements


| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.26.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | ./modules/api_gateway | n/a |
| <a name="module_backend_lambda_function"></a> [backend\_lambda\_function](#module\_backend\_lambda\_function) | ./modules/lambda | n/a |
| <a name="module_frontend_lambda_function"></a> [frontend\_lambda\_function](#module\_frontend\_lambda\_function) | ./modules/lambda | n/a |
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | ./modules/lambda | n/a |
| <a name="module_lambda_role"></a> [lambda\_role](#module\_lambda\_role) | ./modules/role | n/a |
| <a name="module_secrets_manager"></a> [secrets\_manager](#module\_secrets\_manager) | ./modules/secrets_manager | n/a |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_lambda_source_code_path"></a> [backend\_lambda\_source\_code\_path](#input\_backend\_lambda\_source\_code\_path) | Path to the lambda source code zip file of the backend lambda | `string` | `null` | no |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | Extendable object contains all required environment variables required for the integration. | `map(string)` | <pre>{<br>  "CHECK_POLICY": "Fail on errors only",<br>  "SPECTRAL_DSN": ""<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The target environment name for deployment. | `string` | `"prod"` | no |
| <a name="input_frontend_lambda_source_code_path"></a> [frontend\_lambda\_source\_code\_path](#input\_frontend\_lambda\_source\_code\_path) | Path to the lambda source code zip file of the frontend lambda | `string` | `null` | no |
| <a name="input_gateway_api_integration_timeout_milliseconds"></a> [gateway\_api\_integration\_timeout\_milliseconds](#input\_gateway\_api\_integration\_timeout\_milliseconds) | Timeout for the API Gateway to wait for lambda response | `number` | `29000` | no |
| <a name="input_global_tags"></a> [global\_tags](#input\_global\_tags) | A list of tags to apply on all newly created resources. | `map(string)` | <pre>{<br>  "BusinessUnit": "Spectral"<br>}</pre> | no |
| <a name="input_integration_type"></a> [integration\_type](#input\_integration\_type) | Spectral integration type (A unique phrase describing the integration) - Available values: `github`, `terraform`, `jira` and `gitlab` | `string` | n/a | yes |
| <a name="input_lambda_enable_logs"></a> [lambda\_enable\_logs](#input\_lambda\_enable\_logs) | Specifies if Lambda should have CloudWatch a dedicated logs group. | `bool` | `false` | no |
| <a name="input_lambda_function_memory_size"></a> [lambda\_function\_memory\_size](#input\_lambda\_function\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime. Defaults to 1024. | `number` | `1024` | no |
| <a name="input_lambda_function_timeout"></a> [lambda\_function\_timeout](#input\_lambda\_function\_timeout) | Amount of time your Lambda Function has to run in seconds. | `number` | `300` | no |
| <a name="input_lambda_logs_retention_in_days"></a> [lambda\_logs\_retention\_in\_days](#input\_lambda\_logs\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. | `number` | `30` | no |
| <a name="input_lambda_publish"></a> [lambda\_publish](#input\_lambda\_publish) | Whether to publish creation/change as new Lambda Function Version. | `bool` | `false` | no |
| <a name="input_lambda_source_code_path"></a> [lambda\_source\_code\_path](#input\_lambda\_source\_code\_path) | Path to the lambda source code zip file | `string` | `null` | no |
| <a name="input_resource_name_common_part"></a> [resource\_name\_common\_part](#input\_resource\_name\_common\_part) | A common part for all resources created under the stack | `string` | `null` | no |
| <a name="input_secrets_names"></a> [secrets\_names](#input\_secrets\_names) | Names of secrets to create | `list(string)` | `null` | no |
| <a name="input_store_secret_in_secrets_manager"></a> [store\_secret\_in\_secrets\_manager](#input\_store\_secret\_in\_secrets\_manager) | Whether to store your secrets in secrets manager, default is false | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A collection of tags grouped by key representing it's target resource. | `map(map(string))` | <pre>{<br>  "api_gateway": {},<br>  "iam": {},<br>  "lambda": {}<br>}</pre> | no |

### env_vars

In some integrations, Spectral requires some environment variables besides the default ones.
Those variables should be added to the `env_vars`.

Please refer to our [docs](https://guides.spectralops.io/docs/welcome-to-checkpoint-cloudguard-guides) / source pages to view the extra environment variables needed for the integration.


### global_tags

This variable holds a list of tags be applied on all newly created resources:

```tcl
{
  BusinessUnit = "Spectral"
  ...
}
```

### tags

This variable holds a collection of tags grouped by key representing its target resource:

1. IAM role resource - using the `iam` key
2. Lambda resource - using the `lambda` key
3. ApiGateway resource - using the `api_gateway` key

```tcl
{
  iam = {
    ...
  }
  lambda = {
    ...
  }
  api_gateway = {
    ...
  }
}
```

## Usage

```tcl
module "spectral_lambda_integration" {
  source                        = "github.com/SpectralOps/spectral-terraform-lambda-integration"

  environment                   = "prod"
  integration_type              = "terraform"
  lambda_enable_logs            = true
  lambda_logs_retention_in_days = 30
  lambda_publish                = false
  lambda_function_timeout       = 300
  lambda_function_memory_size   = 1024

  # Environment variables used by the integration
  env_vars = {
    # Mandatory (unless you are using vault) - Your spectral DSN retrieved from SpectralOps
    SPECTRAL_DSN       = ""
    # Additional env-vars should go here
  }

  # Global tags - Tags to be applied on every newly created resource
  global_tags = {
    # Tags to apply to all newly created resources
    BusinessUnit = "Spectral"
  }

  # Tags to be applied on concrete resources
  tags = {
    # Tags to apply on iam related resources
    iam = {
      Resource = "role"
    }
    # Tags to apply on lambda related resources
    lambda = {
      Resource = "lambda"
    }
    # Tags to apply on api_gateway related resources
    api_gateway = {
      Resource = "api_gateway"
    }
  }
}
```

## Resources

| Name      | Type |
| ----------- | ----------- |
| [aws_api_gateway_rest_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_method](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method_response](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_response) | resource |
| [aws_api_gateway_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_lambda_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data |

## Outputs

### This module has the following outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | Amazon Resource Name (ARN) identifying your Lambda Function |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the lambda function |
| <a name="output_lambda_iam_role_arn"></a> [lambda\_iam\_role\_arn](#output\_lambda\_iam\_role\_arn) | Amazon Resource Name (ARN) specifying the role |
| <a name="output_lambda_iam_role_name"></a> [lambda\_iam\_role\_name](#output\_lambda\_iam\_role\_name) | Name of the role |
| <a name="output_rest_api_arn"></a> [rest\_api\_arn](#output\_rest\_api\_arn) | Amazon Resource Name (ARN) identifying your Rest API |
| <a name="output_rest_api_execution_arn"></a> [rest\_api\_execution\_arn](#output\_rest\_api\_execution\_arn) | The execution ARN part to be used in lambda\_permission's source\_arn, not concatenated to other allowed API resources |
| <a name="output_rest_api_id"></a> [rest\_api\_id](#output\_rest\_api\_id) | The ID of the REST API |
| <a name="output_rest_api_lambda_execution_arn"></a> [rest\_api\_lambda\_execution\_arn](#output\_rest\_api\_lambda\_execution\_arn) | The execution ARN part to be used in lambda\_permission's source\_arn, concatenated with allowed API resources (method & path) |
| <a name="output_rest_api_url"></a> [rest\_api\_url](#output\_rest\_api\_url) | The URL for accessing the lambda through the ApiGateway |
| <a name="output_secrets_arns"></a> [secrets\_arns](#output\_secrets\_arns) | Arns of created secrets in secrets manager |

## Support

For GitHub deployment - only bot version 2.x is supported.
The default GitHub bot version that this module deploys is 2.0.4, if you wish to use other versions please set local paths to the relevant ZIP files.