data "archive_file" "this" {
  type        = "zip"
  source_dir  = var.lambda_script_source_dir
  output_path = join("", [var.lambda_script_output_path, var.child_module, ".zip"])
}

resource "aws_lambda_function" "this" {
  filename         = join("", [var.lambda_script_output_path, var.child_module, ".zip"])
  function_name    = join("", [basename(var.parent_module_path), "-lambda-", var.child_module])
  role             = var.iam_role_arn
  handler          = var.lambda_handler
  source_code_hash = filebase64sha256(join("", [var.lambda_script_output_path, var.child_module, ".zip"]))
  runtime          = var.lambda_runtime
  description      = var.description
  timeout          = var.timeout
  environment {
    variables = var.lambda_environment_variables
  }
  tags = var.resource_tags
}