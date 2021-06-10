locals {
  crawler_name = join("", [var.project_name, "-", "crawler", "_", var.target_table, "-", var.env])
}

resource "aws_glue_crawler" "this" {
  database_name  = var.database_name
  name           = local.crawler_name
  role           = var.iam_role_arn
  tags           = var.resource_tags
  schedule       = var.cron_schedule
  table_prefix   = var.prefix
  schema_change_policy {
    delete_behavior = var.delete_behavior
    update_behavior = var.update_behavior
  }
  recrawl_policy {
    recrawl_behavior = var.recrawl_behavior
  }
  s3_target {
    path = var.s3_source_path
  }
  # configuration = configuration
}