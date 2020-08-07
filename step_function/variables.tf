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

variable "module_name" {
  description = "Name of child module - used to create resource name"
  type        = string
}

#Optional variables - default values used unless others specified:

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

variable "variableF" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}

variable "variableG" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}

variable "variableH" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}

variable "variableI" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}

variable "variableJ" {
  description = "Available variable name for passing variable to template file"
  type        = string
  default     = "empty"
}

variable "resource_tags" {
  description = "Defaults to no tags. If needed, env vars can be given in parent module variables.tf, and assigned in child module call"
  type        = map(string)
  default = {
    "tag" = "none given"
  }
}