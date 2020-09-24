# Resource/function: dynamo_db/table

## Purpose
Generic code for generating basic DynamoDB tables

## Description
Generates basic DynamoDB table.

## Terraform functions

### Data sources

### Resources
- `aws_dynamodb_table`
    - generates the table

## Input variables
### Required
- `parent_module_path`
    - path of the module that calls this resource/function
- `module_name`
    - name of child module - used to create resource name
- `attribute_name` 
    - name of attribute - also used as hash_key
- `attribute_type`
    - type of attribute: S, N, or B for (S)tring, (N)umber or (B)inary data

### Optional (default values used unless specified)
- `resource_tags`
    - tags added to resource - should be specified jointly with all other resources in the same module
    - default: `"tag" = "none given"`
- `billing_mode`
    - Billing mode applied - only PAY_PER_REQUEST currently available. PROVISIONED requires including read and write capacity to be included in setup
    - default: `"PAY_PER_REQUEST"`


## Output variables
- `arn`
    - `arn` of the generated table
- `id`
    - `id` of the generated bucket (same as name)

## Example use
The below example generates a table using default input where available.
```sql
module "dynamodb_table" {
  source              = "git::https://github.oslo.kommune.no/REN/aws-reg-terraform-library//dynamodb/table?ref=0.32.dev"
  parent_module_path  = path.module
  module_name         = "dynamodb_table"
  attribute_name      = "state_id"
  attribute_type      = "S"
}
```

## Further work