output "rest_api_id" {
    value = aws_api_gateway_rest_api.this.id
}

output "parent_id" {
    value = aws_api_gateway_rest_api.this.root_resource_id
}

output "authorizer_id" {
    value = aws_api_gateway_authorizer.this.id
}

output "execution_arn" {
    value = aws_api_gateway_rest_api.this.execution_arn
}
