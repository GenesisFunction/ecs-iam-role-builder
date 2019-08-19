data "aws_iam_policy_document" "ecr" {
  statement {
    sid = "EcrGetToken"

    actions = [
      "ecr:GetAuthorizationToken",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "EcrPullImage"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]

    resources = var.ecr_repos
  }
}

resource "aws_iam_policy" "ecr" {
  count  = var.ecr_policy ? 1 : 0
  name   = "${var.role_name}-ecr-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.ecr.json
}

resource "aws_iam_role_policy_attachment" "ecr" {
  count      = var.ecr_policy ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.ecr[0].arn
}

