


# Generates the IAM role with policy to be used by the resource
resource "aws_iam_role" "this" {
  name                 = join("", [basename(var.parent_module_path), "-iam_role-", var.added_name])
  assume_role_policy   = var.assume_policy_path
  description          = var.description
  permissions_boundary = var.permission_boundary
  tags                 = var.resource_tags
}

# Generates the role policy to be used by the resource
resource "aws_iam_role_policy" "this" {
  name   = join("", [basename(var.parent_module_path), "-iam_policy-", var.added_name])
  role   = aws_iam_role.this.id
  policy = var.policy_path
}
