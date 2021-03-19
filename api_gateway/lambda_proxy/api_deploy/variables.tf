variable "rest_api_id" {
  description = "Id of api generated in api_general"
  type = string
}

variable "stage_name" {
  description = "name of api stage"
  type = string
  default = "dev"
}