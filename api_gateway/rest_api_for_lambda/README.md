# Resource/function: api_gateway/rest_api_for_lambda

## Purpose
Generic code for generating a url for invoking lambda functions

## Description
Generates url for invoking lambda functions 

## Terraform functions

### Data sources

### Resources
- `aws_api_gateway_rest_api`
    - description to be added
- `aws_api_gateway_resource`
    - description to be added
- `aws_api_gateway_method`
    - description to be added
- `aws_api_gateway_integration`
    - description to be added
- `aws_api_gateway_deployment`
    - description to be added
- `aws_lambda_permission`
    - description to be added


## Input variables
### Required
- `parent_module_path`
    - path of the module that calls this resource/function
- `lambda_function_invoke_arn`
    - invoke arn of the lambda function to be invoked
- `lambda_function_function_name`
    - function name of the lambda function to be invoked
- `module_name`
    - name of child module - used to create resource name

### Optional (default values used unless specified)
- `resource_tags`
    - tags added to role - should be specified jointly with all other resources in the same module
    - default: `"tag" = "none given"`
- `description`
    - description of role
    - default: `No description given`

## Output variables
- `invokation_url`
    - url for invoking the lambda function

## Example use
The below example generates a url as a module using the terraform scripts from `source`.
```sql
module "api_gateway_rest_api" {
  source = "git::https://github.oslo.kommune.no/REN/aws-reg-terraform-library//api_gateway/rest_api_for_lambda?ref=0.17.dev"
  parent_module_path = path.module
  lambda_function_invoke_arn = module.lambda.invoke_arn
  lambda_function_function_name = module.lambda.function_name
  resource_tags = var.resource_tags
  module_name = "api_gateway_rest_api"
}
```

## Further work
