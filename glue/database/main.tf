resource "aws_glue_catalog_database" "this" {
  name = var.database_name
  description = var.database_description
}