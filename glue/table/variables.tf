# Required variables:
#table name
variable "table_name" {
  description = "Table in the (Data catalog) of Glue service"
  type        = string
}

#database name
variable "database_name" {
  description = "Database name where table is located"
  type        = string
}

#data location in s3
variable "location" {
  description = "Data location in s3"
  type        = string
}

#list of columns in map format: name=type (for ex.  column1="string")
variable "columns" {
  description = "List of columns and types"
  type = map(string)
}

#list of partition keys in map format: name=type (for ex.  column1="string")
variable "partition_keys" {
  description = "List of partition keys"
  type = map(string) 
}

#Optional variables - default values used unless others specified:
#separator
variable "separators" {
  description = "Column separator in csv file"
  type        = string
  default     = ";"
}