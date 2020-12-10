# Required variables:
variable "env" {
  description = "Environment dev/prod"
  type = string
}

variable "api_name" {
  description = "Name of API generated"
  type        = string
}

variable "api_key_name" {
  description = "Name of API key"
  type        = string
}  

variable "target_arn" {
  description = "Arn of target to be invoked - step_function: arn - lambda: invoke_arn"
  type        = string
}

variable "target_type" {
  description = "Target selector for API - valids are <step_function> and <lambda>"
  type        = string
}

# Required variables for Lambda:
variable "lambda_function_name" {
  description = "Name of lambda function to be invoked - only required for lambda"
  type        = string
  default     = ""
} 

# Required variables for Step Function:
variable "iam_role_for_api_gateway_to_invoke_step_function" {
  description = "IAM role required for API Gateway to invoke step function"
  type        = string
  default     = ""
} 

#Optional variables - default values used unless others specified:
variable "api_description" {
  description = "Description of API generated"
  type        = string
  default     = "None given"
}

variable "stage_name" {
  description = "Name of API stage"
  type        = string
  default     = "stagename"
}  

variable "resource_path_part" {
  description = "Path part of the API resource generated (one word)"
  type        = string
  default     = "pathpart"
}

variable "usage_plan_name" {
  description = "Name of usage plan"
  type        = string
  default     = "usageplanname"
}

variable "api_response_200" {
  description = "Response text from API for status code 200"
  type        = string
  default     = "Status code 200"
} 

variable "add_cors" {
  description = "Boolean for including CORS or not"
  type        = string
  default     = false
} 

variable "resource_tags" {
  description = "Defaults to no tags. If needed, env vars can be given in parent module variables.tf, and assigned in child module call"
  type        = map(string)
  default = {
    "tag" = "none given"
  }
}