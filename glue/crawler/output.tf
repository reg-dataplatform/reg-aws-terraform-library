output "name" {
  description = "Glue crawler name"
  value       = aws_glue_crawler.this.name
}

output "arn" {
  description = "Glue crawler arn"
  value       = aws_glue_crawler.this.arn
}

output "id" {
  description = "Glue crawler id"
  value       = aws_glue_crawler.this.id
}