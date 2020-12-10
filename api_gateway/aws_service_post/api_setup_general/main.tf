
# Generate an api id
resource "aws_api_gateway_rest_api" "this" {
  name        = join("", [var.api_name, "-", var.env])
  description = var.api_description
  api_key_source = "HEADER"
  tags        = var.resource_tags
}

# Generate a resource (path in our api to be pointing to an object)
resource "aws_api_gateway_resource" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = var.resource_path_part
}

# Generate a method for communicating with the resource
resource "aws_api_gateway_method" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
}

# Set up responses to api requests
resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = "200"
  depends_on = [
    aws_api_gateway_method.this,
  ]
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

# Set up responses to api requests
resource "aws_api_gateway_integration_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
  depends_on = [
    aws_api_gateway_integration.step_function,
    aws_api_gateway_integration.lambda,
    aws_api_gateway_method_response.response_200,
  ]
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "{\"body\": \"${var.api_response_200}\"}"
  }
}


data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

## STEP FUNCTION SPECIFIC:
# Set up api gateway integration for step function

# Add permission for api to invoke step function



resource "aws_api_gateway_integration" "step_function" {
  count = var.target_type == "step_function" ? 1 : 0

  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  passthrough_behavior    = "NEVER"
  credentials             = var.iam_role_for_api_gateway_to_invoke_step_function
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:states:action/StartExecution"
  request_templates = {
    "application/json" = <<EOF
{
    "input": "$util.escapeJavaScript($input.json('$'))",
    "stateMachineArn": "${var.target_arn}"
}
EOF
  }
}


## LAMBDA SPECIFIC:
# Set up api gateway integration for step function
resource "aws_api_gateway_integration" "lambda" {
  count = var.target_type == "lambda" ? 1 : 0

  rest_api_id          = aws_api_gateway_rest_api.this.id
  resource_id          = aws_api_gateway_resource.this.id
  http_method          = aws_api_gateway_method.this.http_method
  type                 = "AWS"    # AWS indicates AWS service
  integration_http_method = "POST"      
  uri                  = var.target_arn
}

# Add permission for api to invoke lambda
resource "aws_lambda_permission" "lambda" {
  count = var.target_type == "lambda" ? 1 : 0

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.this.http_method}${aws_api_gateway_resource.this.path}"
}
