output "lambda_function_name" {
  value = aws_lambda_function.test-function.function_name
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.prod_cf_dist.id
}
output "aws_codepipeline_name" {
  value = aws_codepipeline.codepipeline.id
}
output "lambda_role" {
  value = aws_iam_role.lambda.id
}

output "lambda_policy" {
  value = aws_iam_policy.custom_managed_policy.id
}

output "iam_prod_bucket_policy_document" {
  value = data.aws_iam_policy_document.prod_bucket_policy_document.id
}