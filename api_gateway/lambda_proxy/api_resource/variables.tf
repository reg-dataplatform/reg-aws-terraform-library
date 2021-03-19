variable "rest_api_id" {
  description = "Id of api generated in api_general"
  type = string
}

variable "parent_id" {
  description = "Corresponds to the api root_resource_id generated in api_general"
  type = string
}

variable "authorizer_id" {
  description = "Id of authorizer generated in api_general"
  type = string
}

variable "execution_arn" {
  description = "The API exrcution arn used for generating lambda permission"
  type = string
}

variable "use_request_parameters" {
  description = "Whether or not request parameter is used"
  type = bool
  default = false
}

variable "request_parameter_name" {
  description = "Name of request parameter if used"
  type = string
  default = "method"
}

variable "resource_name" {
  description = "Name of resource - typically containing a method and integration pointing to a specific lambda function."
  type = string
  default = "main_resource"
}

variable "lambda_target_function_name" {
  description = "Name of target lambda function"
  type = string
}

variable "lambda_target_invoke_arn" {
  description = "Invoke arn of target lambda function"
  type = string
}