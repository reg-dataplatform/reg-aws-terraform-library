variable "env" {
  description = "Environment dev/prod"
  type = string
}

variable "api_id" {
  description = "Id of generated API"
  type        = string
}

variable "stage_name" {
  description = "Name of API stage"
  type        = string
}

variable "usage_plan_name" {
  description = "Name of usage plan"
  type        = string
}

variable "api_key_name" {
  description = "Name of API key"
  type        = string
}

variable "resource_tags" {
  description = "Defaults to no tags. If needed, env vars can be given in parent module variables.tf, and assigned in child module call"
  type        = map(string)
}