output "arn" {
  description = "Bucket arn"
  value       = aws_s3_bucket.this.arn
}

output "name" {
  description = "Bucket name"
  value       = aws_s3_bucket.this.bucket
}