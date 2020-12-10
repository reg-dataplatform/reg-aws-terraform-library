# Resource/function: api_gateway/aws_service_post

## Purpose
Generic code for generating a rest api to invoke aws service using POST. Currently supports lambda and step function. 

## Description
Generates api url for sending json payload to lambda or step function. Payload can be empty. Generates api-key required to use api. 

The Terraform setup is split in 3 modules because Terraform fails to identify the correct sequence of deploying. 
1. api_setup_general - generates the api
2. cors_setup - enables cors, required for using api from web browsers. Only constructed if add_cors variable is set to true.
3. deployment - deploys api and generates api key

## Terraform functions

### Data sources
- `aws_region`
    - gets region
- `aws_caller_identity`
    - gets account id

### Resources
#### api_setup_general
- `aws_api_gateway_rest_api`
    - generates the api id
- `aws_api_gateway_resource`
    - generate a resource (path in our api to be pointing to an object)
- `aws_api_gateway_method`
    - generate a method for communicating with the resource
- `aws_api_gateway_integration`
    - generates the integration between the api and the aws service
- `aws_api_gateway_method_response`
    - set up responses to api requests 
- `aws_api_gateway_integration_response`
    - set up responses to api requests 
- `aws_lambda_permission`
    - sets up lambda permission to allow api gateway to invoke lambda

#### cors_setup
- `aws_api_gateway_method`
    - generate a method for communicating with the resource
- `aws_api_gateway_integration`
    - generates the integration between the api and the aws service
- `aws_api_gateway_method_response`
    - set up responses to api requests 
- `aws_api_gateway_integration_response`
    - set up responses to api requests 

#### deployment_setup
- `aws_api_gateway_deployment`
    - deploys the api, i.e. makes it available for use. MUST BE DONE LAST
- `aws_api_gateway_api_key`
    - generates the api key
- `aws_api_gateway_usage_plan`
    - required for setting up key
- `aws_api_gateway_usage_plan_key`
    - required for setting up key


## Input variables
### Required
- `env`
    - environment dev/prod
- `api_name`
    - name of API generated
- `api_key_name`
    - name of API key
- `target_arn`
    - arn of target to be invoked - for step_function: arn - for lambda: invoke_arn
- `target_type`
    - target selector for API - valids are `step_function` and `lambda`. Tells Terraform the correct resources to deploy

### Required variables for Lambda
- `lambda_function_name`
    - name of lambda function to be invoked - only required for lambda

### Required variables for Step Function
- `iam_role_for_api_gateway_to_invoke_step_function`
    - IAM role required for API Gateway to invoke step function

### Optional (default values used unless specified)
- `api_description`
    - description of API generated
    - default: `None given`
- `stage_name`
    - name of API stage
    - default: `stagename`
- `resource_path_part`
    - path part of the API resource generated (one word)
    - default: `pathpart`
- `usage_plan_name`
    - name of usage plan
    - default: `usageplanname`
- `api_response_200`
    - response text from API for status code 200
    - default: `Status code 200`
- `resource_tags`
    - tags added to role - should be specified jointly with all other resources in the same module
    - default: `"tag" = "none given"`
- `add_cors`
    - boolean for including CORS or not
    - default: `false`

## Output variables
- `api_key_value`
    - api key generated
    - usage
        - key = `x-api-key`
        - value = `api_key_value`
        - add to `HEADER`
- `invoke_url_stage`
    - stage url generated
- `invoke_url_path_part`
    - path part given as input
    - usage
        - POST url = `invoke_url_stage` + `/` + `invoke_url_path_part`

## Example use - Lambda
The below example generates a api for invoking Lambda.
```sql
module "api_setup" {
    source              = "git::https://github.com/reg-dataplatform/reg-aws-terraform-library//api_gateway/aws_service_post?ref=0.36.dev"
    env                 = var.env
    api_name            = "my_lambda_api"
    api_description     = "Testing lambda api"
    stage_name          = "lambda_stage" #has default
    resource_path_part  = "lambda_path_part" #has default
    usage_plan_name     = "lambda_usage_plan" #has default
    api_key_name        = "lambda_api_key"
    target_arn          = module.lambda_test_form_setup.invoke_arn
    target_type         = "lambda"
    lambda_function_name = module.lambda_test_form_setup.function_name
    depends_on = [
        module.lambda_test_form_setup
    ]
}
```

## Example use - Step Function
The below example generates a api for invoking Lambda.
```sql
module "api_setup" {
    source              = "git::https://github.com/reg-dataplatform/reg-aws-terraform-library//api_gateway/aws_service_post?ref=0.36.dev"
    env                 = var.env
    api_name            = "my_step_function_api"
    api_description     = "Testing step function api"
    stage_name          = "step_function_stage" #has default
    resource_path_part  = "step_function_path_part" #has default
    usage_plan_name     = "step_function_usage_plan" #has default
    api_key_name        = "step_function_api_key"
    target_arn          = module.step_function.arn
    target_type         = "step_function"
    iam_role_for_api_gateway_to_invoke_step_function = module.iam_role_for_api_gateway.arn
    api_response_200    = "200: Message recieved"
    add_cors            = false
    resource_tags       = local.resource_tags
    depends_on = [
        module.step_function
    ]
}
```

## Further work
Currently a beta version - needs further testing and development