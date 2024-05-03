data "aws_iam_policy_document" "ap_ecs_execution_role-assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "ecs.amazonaws.com",
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_policy" "ap_execution_policy" {
  name = "${var.PREFIX}__ap-execution-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "SSM"
        Effect = "Allow"
        Action = [
          "ssm:GetParametersByPath",
          "ssm:GetParameters"
        ]
        Resource = [
          "arn:aws:ssm:${var.AWS_REGION}:*:parameter/${var.PREFIX}/*",
        ]
      },
      {
        Sid    = "Logs"
        Effect = "Allow"
        Action = [
          "logs:DescribeLogGroups",
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:PutRetentionPolicy",
          "logs:CreateLogGroup",
          "logs:GetLogEvents",
          "logs:PutLogEvents",
        ],
        Resource = [
          "arn:aws:logs:${var.AWS_REGION}:*:log-group:/activepieces/${var.PREFIX}",
          "arn:aws:logs:${var.AWS_REGION}:*:log-group:/activepieces/${var.PREFIX}:log-stream:*",
        ]
      },

    ]
  })
}

resource "aws_iam_role" "ap_execution_role" {
  name               = "${var.PREFIX}__ap_execution_role"
  assume_role_policy = data.aws_iam_policy_document.ap_ecs_execution_role-assume_policy.json
}

resource "aws_iam_role_policy_attachment" "eb_execution_role-role_attach" {
  role       = aws_iam_role.ap_execution_role.name
  policy_arn = aws_iam_policy.ap_execution_policy.arn
}

output "iam_execution_role_arn" {
  value = aws_iam_role.ap_execution_role.arn
}
