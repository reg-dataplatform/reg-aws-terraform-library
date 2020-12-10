module "api_setup_general" {
    source              = "./api_setup_general"
    env                 = var.env
    api_name            = var.api_name
    api_description     = var.api_description
    resource_path_part  = var.resource_path_part
    target_arn          = var.target_arn
    target_type         = var.target_type
    lambda_function_name = var.lambda_function_name
    iam_role_for_api_gateway_to_invoke_step_function = var.iam_role_for_api_gateway_to_invoke_step_function
    api_response_200    = var.api_response_200
    resource_tags       = var.resource_tags
}

module "cors_setup" {
    count = var.add_cors ? 1 : 0

    source              = "./cors_setup"
    api_id              = module.api_setup_general.api_id
    api_resource_id     = module.api_setup_general.api_resource_id
    depends_on          = [
        module.api_setup_general
    ]
}

module "deployment_setup" {
    source              = "./deployment_setup"
    env                 = var.env
    api_id              = module.api_setup_general.api_id
    stage_name          = var.stage_name
    usage_plan_name     = var.usage_plan_name
    api_key_name        = var.api_key_name
    resource_tags       = var.resource_tags
    depends_on          = [
        module.api_setup_general,
        module.cors_setup
    ]
}





