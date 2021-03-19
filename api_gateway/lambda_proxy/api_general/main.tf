
# Generate an api id
resource "aws_api_gateway_rest_api" "this" {
  name        = join("", [var.api_name, "-", var.env])
  description = var.api_description
  api_key_source = "HEADER"
  tags        = var.resource_tags
}

resource "aws_iam_role" "this" {
  name = join("", [var.api_name, "-authorizer_role-", var.env])
  path = "/"
  permissions_boundary = var.permission_boundary
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "apigateway.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "this" {
  name = join("", [var.api_name, "-authorizer_role_policy-", var.env])
  role = aws_iam_role.this.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "lambda:InvokeFunction",
        "Effect": "Allow",
        "Resource": "${var.lambda_authorizer_arn}"
      }
    ]
  }
  EOF
}


resource "aws_api_gateway_authorizer" "this" {
  name                   = join("", [var.api_name, "-authorizer-", var.env])
  rest_api_id            = aws_api_gateway_rest_api.this.id
  authorizer_uri         = var.lambda_authorizer_invoke_arn
  authorizer_credentials = aws_iam_role.this.arn
  identity_source        = join("", ["method.request.header.", var.request_header_for_authorization]) 
}


