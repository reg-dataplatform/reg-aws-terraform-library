variable "api_name" {
  description = "Name of API generated"
  type        = string
}

variable "api_description" {
  description = "Description of API generated"
  type        = string
}

variable "resource_path_part" {
  description = "Path part of the API resource generated (one word)"
  type        = string
}

variable "target_arn" {
  description = "Arn of the function to be invoked (invoke_arn for lambda)"
  type        = string
}

variable "target_type" {
  description = "Target for API - valids are <step_function> and <lambda>"
  type        = string
}

variable "env" {
  description = "Environment dev/prod"
  type = string
}

variable "lambda_function_name" {
  description = "Name of lambda function to be invoked"
  type        = string
} 

variable "iam_role_for_api_gateway_to_invoke_step_function" {
  description = "IAM role required for API Gateway to invoke step function"
  type        = string
} 

variable "api_response_200" {
  description = "Response text from API for status code 200"
  type        = string
} 

variable "resource_tags" {
  description = "Defaults to no tags. If needed, env vars can be given in parent module variables.tf, and assigned in child module call"
  type        = map(string)
}
