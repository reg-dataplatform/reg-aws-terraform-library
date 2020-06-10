# Required variables:

variable "parent_module_path" {
  description = "Path of the parent module - to be used for naming resources etc"
  type        = string
}

variable "lambda_function_invoke_arn" {
  description = "Invoke arn of the lambda function to be invoked"
  type        = string
}

variable "lambda_function_function_name" {
  description = "Function name of the lambda function to be invoked"
  type        = string
}


#Optional variables - default values used unless others specified:

variable "added_name" {
  description = "Name of child module - default value ok if module contains only one role"
  type        = string
  default     = "main"
}

variable "resource_tags" {
  description = "Defaults to no tags. If needed, env vars can be given in parent module variables.tf, and assigned in child module call"
  type        = map(string)
  default = {
    "tag" = "none given"
  }
}

variable "description" {
  description = "Description of the cron setup"
  type        = string
  default     = "No description given"
}