
# Generate an api id
resource "aws_api_gateway_rest_api" "this" {
  name        = join("", [var.api_name, "-", var.env])
  description = var.api_description
  api_key_source = "HEADER"
  tags        = var.resource_tags
}


resource "aws_api_gateway_authorizer" "this" {
  name                   = join("", [var.api_name, "-authorizer-", var.env])
  rest_api_id            = aws_api_gateway_rest_api.this.id
  authorizer_uri         = var.lambda_authorizer_invoke_arn
  authorizer_credentials = var.lambda_authorizer_role_arn
  identity_source        = join("", ["method.request.header.", var.request_header_for_authorization]) 
}


