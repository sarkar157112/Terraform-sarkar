
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/script/${var.source_file_name}"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "test-function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = data.archive_file.lambda.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda.arn
  handler       = "index.test_function"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }
}