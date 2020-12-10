# Required variables:
variable "env" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "database_name" {
  description = "Database name in the (Data catalog) of Glue service"
  type        = string
}

variable "target_table" {
  description = "target athena table"
  type        = string
}

variable "iam_role_arn" {
  description = "Arn of generated role"
  type        = string
}

variable "s3_source_path" {
  description = "path of s3 source"
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