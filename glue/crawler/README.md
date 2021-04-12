# Resource/function: Glue. Data catalog. crawler

## Purpose
Generic code for generating crawler in the data catalog.

## Description
Establishes a Glue crawler in the Data Catalog. 

### Resources
- `aws_glue_crawler` 
    - establishes crawlers 

## Input variables
### Required
- `env`
    - environment  (dev/prod)

- `project_name`
    - name of the project - used as prefix in the crawler-name

- `database_name`
    - database name - where the table will be created

- `target_table`
    - target table - used as part of crawler-name

- `iam_role_arn`
    - iam role arn - assigned iam role

- `schedule`
    - schedule - cron format for automated run

- `s3_source_path`
    - s3 source - path of the source

### Optional (default values used unless specified)
- `resource_tags`
    - tags of crawler
    - default: `"tag" = "none given"`

## Output variables
- `name`
    - name of the crawler
- `arn`
    - arn of the crawler
- `id`
    - id of the crawler

## Example use
The below example generates a crawler as a module using the terraform scripts

```sql
module "crawler_fact_visit_station" {
  source         = "git::https://github.com/reg-dataplatform/reg-aws-terraform-library//glue/database?ref=0.35.dev"
  providers      = {aws = aws}
  env            = var.env
  project_name   = var.project_name
  database_name  = var.database_name
  target_table   = var.table_fact_name
  iam_role_arn   = module.iam_role_for_glue.arn
  resource_tags  = var.resource_tags
  s3_source_path = "s3://${var.dataplatform_bucket}/${var.s3_path_key}"
}
```

## Further work
