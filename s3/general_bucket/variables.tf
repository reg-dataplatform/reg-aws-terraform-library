
# Required variables:

variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
}


#Optional variables - default values used unless others specified:

variable "bucket_acl" {
  description = "Name of the bucket"
  type        = string
  default     = "private"
}

variable "enable_versioning" {
  description = "Enable bucket versioning - cannot be turned off once on"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Defaults to no tags."
  type        = map(string)
  default = {
    "tag" = "none given"
  }
}