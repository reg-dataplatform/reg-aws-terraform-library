# Resource/function: Glue. Data catalog. tables

## Purpose
Generic code for generating csv tables in the glue data catalog.

## Description
Establishes ONLY csv tables which are separated by ";". 
IMPORTANT! All names must use only "_",  but not "-"

### Resources
- `aws_glue_catalog_table` 
    - establishes tables 

## Input variables
### Required
- `table_name`
    - table name.   IMPORTANT! All names must use only "_",  but not "-"
- `database_name`
    - database name where table is located.
      IMPORTANT! All names must use only "_",  but not "-"
- `location`
    - Data location in s3 (s3://bucket_name/folder_name)
- `columns`
    - list of columns in map format: name=type (for ex.  column1="string")
      IMPORTANT! All names must use only "_",  but not "-"
- `partition_keys`
    - list of partitions in map format: name=type (for ex.  year="string")


### Optional (default values used unless specified)
- `separators`
    - Column separator in csv file
    - default: `;`

## Output variables
- `arn`
    - `arn`  of the Glue Table.
- `id`
    - Catalog ID, Database name and of the name table
- `name`
    - name of the lambda function

## Example use
The below example generates a Glue table as a module using the terraform scripts from `source`.  `iam_role_arn` is not needed for Glue table . 
The script use `columns` and `partition_keys` which have type `map(string)`.
Module depends on database name `module.glue_data_catalog_database.name` 

```sql
module "glue_table_norsk_gjenvinning" {
  source  = "git::https://github.oslo.kommune.no/REN/aws-reg-terraform-library//glue/table?ref=0.28.dev"
  table_name = var.table_name
  database_name = module.glue_data_catalog_database.name
  location = var.location
  columns = var.table_columns
  partition_keys = var.partition_keys
}
```

## Further work
* Develop `json` format of file 
* Add additional options such as `input_format`, `output_format`, etc.