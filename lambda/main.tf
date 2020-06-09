
resource "local_file" "additional_file" {
  count = var.additional_file_include ? 1 : 0
  filename = join("", [var.lambda_script_source_dir, "/", var.additional_file_target])
  content  = file(var.additional_file_path)
}

data "archive_file" "this" {
  count = var.additional_file_include ? 0 : 1
  type        = "zip"
  output_path = join("", [var.lambda_script_output_path, var.child_module, ".zip"])
  source_dir  = var.lambda_script_source_dir
}

data "archive_file" "that" {
  count = var.additional_file_include ? 1 : 0
  type        = "zip"
  output_path = join("", [var.lambda_script_output_path, var.child_module, ".zip"])
  source_dir  = var.lambda_script_source_dir
  depends_on = [
    local_file.additional_file,
  ]
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