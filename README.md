# aws-reg-terraform-library

## Purpose
This library contains standardized resources/functions for building aws modules. The target is to build each resource/function such that they can be used together by referencing them as modules without the need of specifying any further connection.  

## Layout
The library contains separate folders for each resource/function to biuld. Within each folder, the following Terraform files are located:
- `main.tf` - contains the detailed code for how the resource/function shall be built.
- `variables.tf` - contains input variables to `main.tf`
- `output.tf` - contains output variables to be passed to other resources/functions

Each folder also contains a `README.md` describing functionality and dependency of each file. 

## Structure
The following shows the currently available resources/functions and their location in the library:

    .
    ├── api_gateway
    │    ├── rest_api_for_lambda
    ├── cloudwatch
    │    ├── cron_for_lambda
    ├── iam
    ├── lambda
