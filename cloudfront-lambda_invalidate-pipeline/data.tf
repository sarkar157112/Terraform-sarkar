# Retrieve the AWS account ID
data "aws_caller_identity" "current" {}

# Retrieve the AWS codepipeline_role
data "aws_iam_role" "codepipeline_role" {
  name = "AWSCodePipelineServiceRole-us-east-1-hhh"
}

# data source to fetch aws lambda function
/*data "aws_lambda_function" "function-name" {
  function_name = var.lambda_function_name        //"test-function"
}*/

# data source to generate bucket policy to let OAI get objects:
data "aws_iam_policy_document" "prod_bucket_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.prod_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.oai.iam_arn}"]
    }
  }

  statement {
    actions = ["s3:*"]
    resources = [
      "${aws_s3_bucket.prod_bucket.arn}",
      "${aws_s3_bucket.prod_bucket.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}
