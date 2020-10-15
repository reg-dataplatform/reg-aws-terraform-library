output "arn" {
  description = "Bucket arn"
  value       = aws_s3_bucket.this.arn
}

output "name" {
  description = "Bucket name"
  value       = aws_s3_bucket.this.bucket
}

output "id" {
  description = "Bucket id"
  value       = aws_s3_bucket.this.id
}

output "website_endpoint" {
  description = "Bucket bucket"
  value       = aws_s3_bucket.this.website_endpoint
}

output "website_domain" {
  description = "Bucket bucket"
  value       = aws_s3_bucket.this.website_domain
}

output "hosted_zone_id" {
  description = "Bucket bucket"
  value       = aws_s3_bucket.this.hosted_zone_id
}