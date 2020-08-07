resource "aws_sfn_state_machine" "this" {
  name     = join("", [basename(var.parent_module_path), "-", var.module_name])
  role_arn = var.iam_role_arn
  definition = templatefile(var.template_file_source_dir,
    {
    variableA = var.variableA
    variableB = var.variableB
    variableC = var.variableC
    variableD = var.variableD
    variableE = var.variableE
    variableF = var.variableE
    variableG = var.variableE
    variableH = var.variableE
    variableI = var.variableE
    variableJ = var.variableE
    })
  tags = var.resource_tags
}