output "id" {
  description = "Glue table id"
  value       = aws_glue_catalog_table.this.id
}

output "name" {
  description = "Glue table name"
  value       = aws_glue_catalog_table.this.name
}

output "arn" {
  description = "Glue table arn"
  value       = aws_glue_catalog_table.this.arn
}