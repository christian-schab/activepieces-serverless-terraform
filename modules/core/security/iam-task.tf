data "aws_iam_policy_document" "ap_ecs_task_role-assume_policy" {
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

resource "aws_iam_policy" "ap_task_policy" {
  name = "${var.PREFIX}__ap-task-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "iam:PassRole",
        "Resource": "arn:aws:iam::927245758738:role/dev-pbaa__ap_execution_role"
      }
    ]
  })
}

resource "aws_iam_role" "ap_task_role" {
  name               = "${var.PREFIX}__ap_task_role"
  assume_role_policy = data.aws_iam_policy_document.ap_ecs_task_role-assume_policy.json
}

resource "aws_iam_role_policy_attachment" "eb_task_role-role_attach" {
  role       = aws_iam_role.ap_execution_role.name
  policy_arn = aws_iam_policy.ap_task_policy.arn
}

output "iam_task_role_arn" {
  value = aws_iam_role.ap_task_role.arn
}
