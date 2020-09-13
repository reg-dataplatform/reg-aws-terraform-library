# Resource/function: Glue. Data catalog. database

## Purpose
Generic code for generating database in the data catalog.

## Description
Establishes a database. 

## Input variables
### Required
- `name`
    - name of database - used to create resource name

### Optional (default values used unless specified)
- `description`
    - description of database
    - default: `No description given`

## Output variables
- `name`
    - name of the database
- `arn`
    - arn of the database

## Example use
The below example generates a database as a module using the terraform scripts

```sql
module "glue_data_catalog_database" {
  source                        = "git::https://github.oslo.kommune.no/REN/aws-reg-terraform-library//glue/database?ref=0.26.dev"
  name = "scanx_db"
  description = "this database is for the ScanX dashboard"
}
```

## Further work
