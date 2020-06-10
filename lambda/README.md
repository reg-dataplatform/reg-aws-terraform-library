# Resource/function: lambda

## Purpose
Generic code for generating lambda executable including generation of script package.

## Description
Establishes a lambda executable using standardized naming and input, including generation of script package from folder. 

## Terraform functions

### Data sources
- `archive_file`
    - generates .zip file from folder

### Resources
- `local_file`
    - copies file from any location into .zip source folder
- `aws_lambda_function` 
    - establishes lambda function 

## Input variables
### Required
- `parent_module_path`
    - path of the module that calls this resource/function
- `iam_role_arn`
    - arn of iam role to be used by lambda script
- `lambda_script_source_dir`
    - path to folder containing all files to be uploaded in .zip
- `lambda_script_output_path`
    - path where .zip file will be stored locally
- `lambda_handler`
    - execution handler used to invoke lambda

### Optional (default values used unless specified)
- `added_name`
    - name added to lambda in aws - could be used if several lambdas are needed within the same module
    - default: `main`
- `lambda_runtime`
    - Runtime environment to be used when executing lambda
    - default: `python3.7`
- `description`
    - description of role
    - default: `No description given`
- `timeout`
    - Timeout limitation for execution of scripts, in seconds
    - default: `3`
- `lambda_environment_variables`
    - Environment variables available when executing lambda
    - default: `"env_var" = "none given"`
- `resource_tags`
    - tags added to lambda - should be specified jointly with all other resources in the same module
    - default: `"tag" = "none given"`
- `additional_file_include`
    - option to include script file from other location than `lambda_script_source_dir`. Accepts `true` or `false`.
    - default: `false`
- `additional_file_path`
    - path to additional file
    - default: `./`
- `additional_file_target`
    - target location for additional file. Must be inside `lambda_script_source_dir`. 
    - default: `./`


## Output variables
- `arn`
    - `arn` of the lambda function
- `invoke_arn`
    - `arn` needed to invoke lambda from other resources
- `function_name`
    - name of the lambda function

## Further work
