locals {
  id = replace(var.name, " ", "-")
}

resource "aws_cloudwatch_log_group" "this" {
  count = local.id != ""? 1 : 0
  name              = local.id
  retention_in_days = var.retention_in_days
  tags              = var.tags
}

resource "aws_cloudwatch_log_stream" "this" {
  count = length(var.streams)
  name  = element(var.streams, count.index)
  log_group_name = aws_cloudwatch_log_group.this.0.name
}

data "aws_iam_policy_document" "this" {
  count = local.id != ""? 1 : 0  
  statement {
    actions = ["logs:DescribeLogGroups","logs:DescribeLogStreams"]

    resources = ["*"]
  }

  statement {
    actions = [
      "logs:PutLogEvents",
    ]

    resources = [
      aws_cloudwatch_log_group.this.0.arn,
    ]
  }

  statement {
    actions = var.additional_permissions

    resources = [
      aws_cloudwatch_log_group.this.0.arn,
    ]
  }
}

resource "aws_iam_policy" "this" {
  count = local.id != ""? 1 : 0
  name   = "${local.id}-CloudWatchLogs"
  description = var.description
  policy = data.aws_iam_policy_document.this.0.json
}

# --------------------------------------------------------
# CREATE IAM Policy attachment
# --------------------------------------------------------
resource "aws_iam_role_policy_attachment" "this" {
  count = var.role != "" ? 1 : 0
  role = var.role
  policy_arn = aws_iam_policy.this.0.arn
}
