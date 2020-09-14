output "id" {
  description = "Glue table id"
  value       = aws_glue_catalog_database.this.id
}

output "name" {
  description = "Glue table name"
  value       = aws_glue_catalog_database.this.name
}

output "arn" {
  description = "Glue table arn"
  value       = aws_glue_catalog_database.this.arn
}