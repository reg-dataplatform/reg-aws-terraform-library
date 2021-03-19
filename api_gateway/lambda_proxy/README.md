# Resource/function: api_gateway/lambda_proxy

## Purpose
Generic code for generating a lambda proxy rest api to invoke lambda functions using any request method. 

## Description
Sets up api for invoking lambda function with payload from client and returning json-data to client. Authentication by passing a token in a header is available. API methods are available by passing requests with different query parameters. Multiple resources under the same API, pointing to different lambda functions, are possible. 

The Terraform setup is split in 3 modules to simplify setting up multiple resources, and because Terraform fails to identify the correct sequence when deploying. 
1. api_general - generates the api base
2. api_resource - generates the api resource including the request method and integration, and the response integration and method.
3. api_deploy - deploys the api to assigned stage

## Terraform functions


### Resources
#### api_general
- `aws_api_gateway_rest_api`
    - generates the api id
- `aws_api_gateway_authorizer`
    - creates an authorizer, connecting the correct header to the authorization lambda script

#### api_resource
- `aws_api_gateway_resource`
    - generate a resource containing the request method and integration, and the response integration and method
- `aws_api_gateway_method`
    - generate a method for recieving the request, triggering the authentication and passing valid requests to the integration
- `aws_api_gateway_integration`
    - generates the integration between api gateway and lambda. Passes the request and invokes the function
- `aws_lambda_permission`
    - generates a permission letting api gateway invoke the target lambda function
- `aws_api_gateway_integration_response`
    - generates the integration response. For a lambda proxy setup, this just passes the response from lambda to the method response.
- `aws_api_gateway_method_response`
    - passes the response back to client

#### api_deploy
- `aws_api_gateway_deployment`
    - deploys the api, i.e. makes it available for use. 
- `aws_api_gateway_stage`
    - sets the stage of the deployed api


## Variables - `api_general`

### Input - Required
- `env`
    - environment dev/prod
- `api_name`
    - name of API generated
- `resource_tags`
    - tags attached to API - should be specified jointly with all other resources in the same module
- `lambda_authorizer_invoke_arn`
    - invoke arn of lambda authorizer used for authorizing requests
- `lambda_authorizer_role_arn`
    - arn of IAM role granting permission for API Gateway to invoke authorizer lambda

### Input - Optional 
- `api_description`
    - description of API generated
    - default: `API created in Terraform`
- `request_header_for_authorization`
    - name of header to use for passing authorization token
    - default: `token`

### Output
- `rest_api_id`
    - id of the api generated
- `parent_id`
    - corresponds to the api root_resource_id
- `authorizer_id`
    - id of authorizer
- `execution_arn`
    - the API execution arn used for generating lambda permission

## Variables - `api_resource`

### Input - Required
- `rest_api_id`
    - id of the api generated in api_general
- `parent_id`
    - corresponds to the api root_resource_id generated in api_general
- `authorizer_id`
    - id of authorizer generated in api_general
- `execution_arn`
    - the API execution arn used for generating lambda permission
- `lambda_target_function_name`
    - name of target lambda function
- `lambda_target_invoke_arn`
    - invoke arn of target lambda function

### Input - Optional 
- `use_request_parameters`
    - boolean - whether or not request parameter is used
    - default: `false`
- `request_parameter_name`
    - name of request parameter if used
    - default: `method`
- `resource_name`
    - name of resource - typically containing a method and integration pointing to a specific lambda function
    - default: `main_resource`

### Output
- `invoke_url_path_part`
    - corresponds to the resource name - required when making requests


## Variables - `api_deploy`

### Input - Required
- `rest_api_id`
    - id of the api generated in api_general

### Input - Optional 
- `stage_name`
    - name of api stage
    - default: `dev`

### Output
- `invoke_url_stage`
    - the main part of the url required for making requests to the api
- `invoke_url_stage_name`
    - the stage name part of the url required for making requests to the api



## Making requests

The requests are made to:
- `{invoke_url_stage}/{invoke_url_stage_name}/{invoke_url_path_part}`

If query parameters are used the following syntax applies:
- `{invoke_url_stage}/{invoke_url_stage_name}/{invoke_url_path_part}?{request_parameter_name}="my_method"`

All requests must be made with the authentication header:
- `{"request_header_for_authorization" : "my_token"}`



## Example use
The below example sets up an api for collecting opening hours. Notice that all three api components must be given. The `api_resource` may be given multiple times for connecting several resources to the same api. Also notice the `depends_on` terraform parameters, included to ensure correct sequence of building. 

```sql
module "api_general" {
  source                            = "git::https://github.com/reg-dataplatform/reg-aws-terraform-library//api_gateway/lambda_proxy/api_general?ref=0.41.dev"
  env                               = var.env
  api_name                          = var.project_name
  api_description                   = "testing api terraform generator"
  resource_tags                     = local.resource_tags
  lambda_authorizer_invoke_arn      = module.lambda_api_token_authorizer.invoke_arn
  lambda_authorizer_role_arn        = aws_iam_role.this.arn
  permission_boundary               = local.permission_boundary
  request_header_for_authorization  = "token"
}

module "api_resource" {
  source                        = "git::https://github.com/reg-dataplatform/reg-aws-terraform-library//api_gateway/lambda_proxy/api_resource?ref=0.39.dev"
  resource_name                 = "main"
  rest_api_id                   = module.api_general.rest_api_id
  parent_id                     = module.api_general.parent_id
  authorizer_id                 = module.api_general.authorizer_id
  execution_arn                 = module.api_general.execution_arn
  use_request_parameters        = true
  request_parameter_name        = "method"
  lambda_target_function_name   = module.lambda_openinghours.function_name
  lambda_target_invoke_arn      = module.lambda_openinghours.invoke_arn
  depends_on                    = [module.api_general]
}

module "api_deploy" {
  source              = "git::https://github.com/reg-dataplatform/reg-aws-terraform-library//api_gateway/lambda_proxy/api_deploy?ref=0.39.dev"
  stage_name          = "dev"
  rest_api_id         = module.api_general.rest_api_id
  depends_on          = [module.api_resource]
}
```

## Further work
