output "arn" {
  value = (var.source_type == "json") ? aws_glue_catalog_table.json_table[*].arn : aws_glue_catalog_table.csv_table[*].arn 
}

output "id" {
  value = (var.source_type == "json") ? aws_glue_catalog_table.json_table[*].id : aws_glue_catalog_table.csv_table[*].id 
}

output "name" {
  value = (var.source_type == "json") ? aws_glue_catalog_table.json_table[*].name : aws_glue_catalog_table.csv_table[*].name 
}