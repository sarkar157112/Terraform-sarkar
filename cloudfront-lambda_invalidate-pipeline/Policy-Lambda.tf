
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "lambda" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "Lambda-terraform" # Replace this with your desired IAM role name
}


data "aws_iam_policy_document" "custom_managed_policy" {
  statement {
    effect = "Allow"
    actions = [
      "codepipeline:PutJobFailureResult",
      "codepipeline:PutJobSuccessResult",
      "cloudfront:CreateInvalidation",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_policy" "custom_managed_policy" {
  name   = "Lambda-policy-terraform" # Replace this with your desired IAM policy name
  policy = data.aws_iam_policy_document.custom_managed_policy.json
}

resource "aws_iam_policy_attachment" "custom_managed_policy_attachment" {
  name       = "Lambda-policy-terraform_AttachmentName" # Replace this with your desired IAM policy attachment name
  policy_arn = aws_iam_policy.custom_managed_policy.arn
  roles      = [aws_iam_role.lambda.name]
}
