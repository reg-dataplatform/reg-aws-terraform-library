output "api_key_value" {
    value = aws_api_gateway_api_key.this.value
}

output "invoke_url_stage" {
    value = aws_api_gateway_deployment.this.invoke_url
}