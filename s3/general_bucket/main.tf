locals {
  bucket_name = "${var.bucket_name}-${var.env}"
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  acl    = var.bucket_acl
  tags   = var.tags

  versioning {
    enabled = var.enable_versioning
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.use_encryption ? [var.sse_algorithm] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = var.sse_algorithm
        }
      }
    }
  }


}