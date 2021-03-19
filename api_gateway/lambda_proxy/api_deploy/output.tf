output "invoke_url_stage" {
    value = aws_api_gateway_deployment.this.invoke_url
}

output "invoke_url_stage_name" {
    value = aws_api_gateway_stage.this.stage_name
}