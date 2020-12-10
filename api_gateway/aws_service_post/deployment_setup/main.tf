resource "aws_api_gateway_deployment" "this" {
  rest_api_id = var.api_id
  stage_name  = var.stage_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_api_key" "this" {
  name = join("", [var.api_key_name, "-", var.env])
  tags = var.resource_tags
}

resource "aws_api_gateway_usage_plan" "this" {
  name         = join("", [var.usage_plan_name, "-", var.env])
  tags         = var.resource_tags
  api_stages {
    api_id = var.api_id
    stage  = aws_api_gateway_deployment.this.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "this" {
  key_id        = aws_api_gateway_api_key.this.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.this.id
}



