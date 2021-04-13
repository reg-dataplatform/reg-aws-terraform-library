# Resource/function: IAM/role_v2

## Purpose
Generic code for generating IAM role including role policy.

## Description
Generates a IAM role based input variables assigning role to desired service and with desired policy, for use by a aws resource. NOTE: least priviledge policies shall be used.

## Terraform functions

### Data sources

### Resources
- `aws_iam_role`
    - provides a iam role
- `aws_iam_role_policy` 
    - defines and attaches the policy document to the role
- `aws_iam_policy_document`
    - generates policy input based on input variables

## Input variables
### Required
- `env`
    - environment (dev/prod)
- `permission_boundary`
    - arn of permission boundary required to generate roles. 
- `project_name`
    - name of project - used to create resource name
- `module_name`
    - name of child module - used to create resource name
- `service_to_assume_role`
    - identifier of service to use role - accepts alias given in default_identifiers variable
- `policy_statements`
    - list of maps including statements. each map in list creates a statement in policy.
    - syntax:
    ```json
        [
            {
                effect              = string - optional - accepts "Allow"|"Deny" - defaults to "Allow"
                actions             = list(string) - required - multiple values accepted
                resources           = list(string) - required - accepts resource arn - multiple values accepted
                condition_test      = string - optional
                condition_variable  = string - optional
                condition_values    = list(string) - optional - multiple values accepted
            },
            {
                new map in list - included in same policy
            }

        ]
    ```

### Optional (default values used unless specified)
- `resource_tags`
    - tags added to role - should be specified jointly with all other resources in the same module
    - default: `"tag" = "none given"`
- `description`
    - description of role
    - default: `No description given`
- `role_assumer_actions`
    - action controlled by the defined policy
    - default: `["sts:AssumeRole"]`
- `role_assumer_type`
    - type of principal to use role
    - default: `"Service"`

### Helper variable
- `default_identifiers`
    - map containing key:value pairs where key can be used as alias for connecting policy to service. 

## Output variables
- `arn`
    - `arn` of the generated role

<!---
## Example use
The below example generates a iam role as a module using the terraform scripts from `source`, giving the permissions defined in `policy_path`.
```sql
module "iam_role_for_lambda" {
  source              = "git::https://github.oslo.kommune.no/REN/aws-reg-terraform-library//iam/role?ref=0.17.dev"
  parent_module_path  = path.module
  permission_boundary = var.permission_boundary
  assume_policy_path  = file(join("", [path.module, "/iam/lambda-role-assume-policy.json"]))
  policy_path         = file(join("", [path.module, "/iam/lambda-role-policy.json"]))
  resource_tags       = var.resource_tags
  module_name         = "iam_role_for_lambda"
}
```
--->
## Further work
