
# Required variables:
variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
}

variable "upload_directory" {
  description = "Name of the bucket"
  type        = string  
}

#Optional variables - default values used unless others specified:
variable "target_key" {
  description = "Name of the bucket"
  type        = string  
  default     = ""
}

variable "bucket_acl" {
  description = "Canned ACL - see https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl for options"
  type        = string
  default     = "private"
}

variable "mime_types" {
  default = {
    html  = "text/html"
    css   = "text/css"
    js    = "application/javascript"
    json  = "application/json"
    csv   = "text/csv"
    sql   = "application/sql"
  }
}

variable "tags" {
  description = "Defaults to no tags."
  type        = map(string)
  default = {
    "tag" = "none given"
  }
}