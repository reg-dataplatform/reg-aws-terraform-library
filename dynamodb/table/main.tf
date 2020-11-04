resource "aws_dynamodb_table" "this" {
  name         = join("", [basename(var.parent_module_path), "-", var.module_name,"-", var.env])
  billing_mode = var.billing_mode
  hash_key     = var.attribute_name
  attribute {
    name = var.attribute_name
    type = var.attribute_type
  }
  tags         = var.resource_tags
}
