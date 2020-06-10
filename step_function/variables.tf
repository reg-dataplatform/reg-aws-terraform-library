# Required variables:

variable "parent_module_path" {
  description = "Path of the parent module - to be used for naming resources etc"
  type        = string
}

variable "iam_role_arn" {
  description = "Arn of generated role"
  type        = string
}

variable "template_file_source_dir" {
  description = "Path to template file describing state machine"
  type        = string
}


#Optional variables - default values used unless others specified:
variable "added_name" {
  description = "Name of child module - default value ok if module contains only one lambda"
  type        = string
  default     = "main"
}

variable "variableA" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}

variable "variableB" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}

variable "variableC" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}

variable "variableD" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}

variable "variableE" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}