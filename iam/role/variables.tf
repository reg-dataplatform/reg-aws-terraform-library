
# Required variables:

variable "permission_boundary" {
  type = string
}

variable "parent_module_path" {
  description = "Path of the parent module - to be used for naming resources etc"
  type        = string
}

variable "assume_policy_path" {
  description = "Path to assume policy json"
  type        = string
}

variable "policy_path" {
  description = "Path to role policy json"
  type        = string
}



#Optional variables - default values used unless others specified:

variable "module_name" {
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
  description = "Description of what lambda function does"
  type        = string
  default     = "No description given"
}