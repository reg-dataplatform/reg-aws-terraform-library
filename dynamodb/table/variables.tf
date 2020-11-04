# Required variables:
variable "env" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "parent_module_path" {
  description = "Path of the parent module - to be used for naming resources etc"
  type        = string
}

variable "module_name" {
  description = "Name of child module - used to create resource name"
  type        = string
}

variable "attribute_name" {
  description = "Attribute name - also used as hash key"
  type        = string
}

variable "attribute_type" {
  description = "S, N, or B for (S)tring, (N)umber or (B)inary data"
  type        = string
}




#Optional variables - default values used unless others specified:

variable "resource_tags" {
  description = "Defaults to no tags. If needed, env vars can be given in parent module variables.tf, and assigned in child module call"
  type        = map(string)
  default = {
    "tag" = "none given"
  }
}

variable "billing_mode" {
  description = "Billing mode applied - only PAY_PER_REQUEST currently available. PROVISIONED requires including read and write capacity to be included in setup"
  type        = string
  default     = "PAY_PER_REQUEST"
}

