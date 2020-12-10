output "api_key_value" {
    value = module.deployment_setup.api_key_value
}

output "invoke_url_stage" {
    value = module.deployment_setup.invoke_url_stage
}

output "invoke_url_path_part" {
    value = var.resource_path_part
}