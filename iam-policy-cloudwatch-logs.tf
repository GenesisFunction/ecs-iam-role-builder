data "aws_iam_policy_document" "cloudwatch_logs" {
  statement {
    sid = "CloudWatchLogsDescribe"

    actions = [
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "CloudWatchLogsPut"

    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream"
    ]

    resources = [
      "arn:aws:logs:*:*:log-group:${var.cloudwatch_logs_group_path}:log-stream:*",
    ]
  }
}

resource "aws_iam_policy" "cloudwatch_logs" {
  count  = var.cloudwatch_logs_policy ? 1 : 0
  name   = "${var.role_name}-cloudwatch-logs-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.cloudwatch_logs.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  count      = var.cloudwatch_logs_policy ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.cloudwatch_logs[0].arn
}

