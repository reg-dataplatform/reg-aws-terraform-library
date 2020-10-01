
# Required variables:

variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
}


#Optional variables - default values used unless others specified:

variable "bucket_acl" {
  description = "Canned ACL - see https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl for options"
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

variable "use_encryption" {
  description = "Option to use encryption on bucket - Boolean - defaults to false"
  type        = string
  default     = false
}

variable "sse_algorithm" {
  description = "Selection of encryption algorithm - only required if <use_encryption = True>"
  type        = string
  default     = "AES256"
}