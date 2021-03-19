variable "env" {
  description = "Environment dev/prod"
  type = string
}

variable "api_name" {
  type = string
}

variable "api_description" {
  type = string
  default = "API created in Terraform"
}

variable "resource_tags" {
  type = map(string)
}

variable "lambda_authorizer_invoke_arn" {
  description = "For lambda authorizer this is the invoke_arn"
  type = string
}

variable "lambda_authorizer_arn" {
  description = "The lambda authorizer arn"
  type = string
}

variable "request_header_for_authorization" {
  description = "The request header used to send identification to the authorizer"
  type = string
  default = "token"
}

variable "permission_boundary" {
  description = "Permission boundary required to generate IAM role"
  type = string
}