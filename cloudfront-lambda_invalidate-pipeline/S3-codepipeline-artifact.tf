resource "aws_s3_bucket" "codepipeline_artifact_bucket" {
  bucket = var.codepipeline_artifact_bucket_name
  tags = {
    Name        = var.codepipeline_artifact_bucket_name
    Environment = var.enviroment
  }
}
# Enable the versioning in S3 bucket
resource "aws_s3_bucket_versioning" "codepipeline_artifact_bucket_versioning" {
  bucket = aws_s3_bucket.codepipeline_artifact_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
# Enable the S3 bucket lifecycle configuration 
resource "aws_s3_bucket_lifecycle_configuration" "codepipeline_artifact_lifecycle" {
  rule {
    id     = "artifact_expiration"
    status = "Enabled"

    expiration {
      days = var.s3_object_expiration_days
    }
  }

  bucket     = aws_s3_bucket.codepipeline_artifact_bucket.id
  depends_on = [aws_s3_bucket.codepipeline_artifact_bucket]
}


resource "aws_s3_bucket_public_access_block" "codepipeline_artifact_bucket_public_block" {
  bucket = aws_s3_bucket.codepipeline_artifact_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}
