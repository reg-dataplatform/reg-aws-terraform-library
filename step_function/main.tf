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
    variableF = var.variableF
    variableG = var.variableG
    variableH = var.variableH
    variableI = var.variableI
    variableJ = var.variableJ
    })
  tags = var.resource_tags
}