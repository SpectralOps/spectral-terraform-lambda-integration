<img src="https://user-images.githubusercontent.com/44297242/188002580-ba0a6d59-8b1c-475e-bd61-192dd952194f.png" alt="drawing" style="width:400px;"/>

# spectral-lambda-integration

Terraform configuration used to create the required AWS resources for integrating between Spectral and external service providers.

## Requirements

| Name      | Version |
| ----------- | ----------- |
| [terraform](https://www.terraform.io/downloads)      | ~> 1.2.0    |

## Providers

| Name      | Version |
| ----------- | ----------- |
| [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)      | ~> 4.9    |

## Inputs

| Name      | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| `account_id` | AWS Account ID number of the account in which to manage resources. | `number` | N/A | Yes |
| `aws_region` | The region in which to manage resources.| `string` | N/A | Yes |
| `environment` | The target environment name for deployment | `string` | `prod` | No |
| `integration_type` | Spectral integration type (A unique phrase describing the integration) - Available values: `terraform`, `jira` and `gitlab` | `string` | N/A | Yes |
| [`env_vars`](#env_vars) | Extendable object contains all required environment variables required for the integration. | `map(string)` | N/A | No |
| [`global_tags`](#global_tags) | Tags to be applied on every newly created resource. | `map(string)` | ```{ BusinessUnit = "Spectral" }``` | No |
| [`tags`](#tags) | Tags to be applied on concrete resources  | `map(map(string))` | ```{ iam = { } lambda = { } api_gateway = { } }``` | No |
| `lambda_enable_logs` | Specifies if Lambda should have CloudWatch a dedicated logs group. | `bool` | `false` | No |
| `lambda_logs_retention_in_days` | Specifies the number of days you want to retain log events in the specified log group. | `number` | `30` | No |
| `lambda_function_timeout` | Amount of time your Lambda Function has to run in seconds.  | `number` | 300 | No |
| `lambda_function_memory_size` | Amount of memory in MB your Lambda Function can use at runtime. | `number` | 1024 | No |
| `lambda_publish` | Whether to publish creation/change as new Lambda Function Version. | `bool` | `false` | No |

### env_vars

In some integrations, Spectral requires some extra environment variables besides the default ones.
Those extra variables should be added to the `env_vars` map in addition to `SPECTRAL_DSN` which is mandatory.

Please refer to our docs / source pages to view the extra environment variables needed for the integration.

##### SPECTRAL_DSN (mandatory)

Your SpectralOps identifier, retrieved from your SpectralOps account.

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
  source                        = "github.com/SpectralOps/spectral-terraform-lambda-integration?ref=v1.0.2"

  account_id                    = 111111111111
  aws_region                    = "us-east-1"
  environment                   = "prod"
  integration_type              = "terraform"
  lambda_enable_logs            = true
  lambda_logs_retention_in_days = 30
  lambda_publish                = false
  lambda_function_timeout       = 300
  lambda_function_memory_size   = 1024

  # Environment variables used by the integration
  env_vars = {
    # Mandatory - Your spectral DSN retrieved from SpectralOps
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

1. `rest_api_id` - The ID of the REST API.
2. `rest_api_url` - The URL for accessing the lambda through the ApiGateway.
3. `rest_api_arn` - Amazon Resource Name (ARN) identifying your Rest API.
4. `rest_api_execution_arn` - The execution ARN part to be used in lambda_permission's source_arn, not concatenated to other allowed API resources.
5. `rest_api_lambda_execution_arn` - The execution ARN part to be used in lambda_permission's source_arn, concatenated with allowed API resources (method & path).
6. `lambda_function_arn` - Amazon Resource Name (ARN) identifying your Lambda Function.
7. `lambda_function_name` - The name of the lambda function.
8. `lambda_iam_role_arn` - Amazon Resource Name (ARN) specifying the role.
9. `lambda_iam_role_name` - Name of the role.
