



# Required variables:

variable "parent_module_path" {
  description = "Path of the parent module - to be used for naming resources etc"
  type        = string
}

variable "iam_role_arn" {
  description = "Arn of generated role"
  type        = string
}

variable "lambda_script_source_dir" {
  description = "Directory of lambda package source"
  type        = string
}

variable "lambda_script_output_path" {
  description = "Path to zipped lambda package"
  type        = string
}

variable "lambda_handler" {
  description = "Handler used by lambda to execute script"
  type        = string
}


#Optional variables - default values used unless others specified:

variable "child_module" {
  description = "Name of child module - default value ok if module contains only one lambda"
  type        = string
  default     = "main"
}

variable "lambda_runtime" {
  description = "Name of child module - default value ok if module contains only one lambda"
  type        = string
  default     = "python3.7"
}

variable "description" {
  description = "Description of what lambda function does"
  type        = string
  default     = "No description given"
}

variable "timeout" {
  description = "Timeout limitation for execution of scripts"
  type        = number
  default     = 3
}

variable "lambda_environment_variables" {
  description = "Defaults to no env variables. If needed, env vars can be given in parent module variables.tf, and assigned in child module call"
  type        = map(string)
  default = {
    "env_var"  = "noen given"
  }
}
#
#variable "resource_tags" {
#  description = "Defaults to no tags. If needed, env vars can be given in parent module variables.tf, and assigned in child module call"
#  type        = map(string)
#  default = {
#    "tag"  = "none given"
#  }
#}