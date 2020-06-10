# Resource/function: IAM

## Purpose
Generic code for generating IAM role.

## Description
Generates a IAM role based on input `policy.json` and `assume-policy.json` (not restricted to these names), for use by a aws resource. 

## Input variables
### Required
- `permission_boundary`
    - arn of permission boundary required to generate roles. 
- `parent_module_path`
    - path of the module that calls this resource/function
- `assume_policy_path`
    - path to the assume-policy .json-document
- `policy_path`
    - path to policy .json-document
### Optional (default values used unless specified)
- `child_module`
    - name added to role in aws - could be used if several roles are needed within the same module
    - default: `main`
- `resource_tags`
    - tags added to role - should be specified jointly with all other resources in the same module
    - default: `"tag" = "none given"`
- `description`
    - description of role
    - default: `No description given`

## Output variables
- `arn`
    - `arn` of the generated role

## Further work
- Consider renaming `child_module` accross all resources/functions
- Consider making `resource_tags` as required
- Relocate to subfolder `role` (`IAM/role`)