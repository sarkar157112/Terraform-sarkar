# Create S3 Bucket:
resource "aws_s3_bucket" "prod_bucket" {
  bucket = var.s3_prod_bucket_artifact_deploy
  tags = {
    Name        = var.s3_prod_bucket_artifact_deploy
    Environment = var.enviroment
  }
}
# Enable the versioning in S3 bucket
resource "aws_s3_bucket_versioning" "prod_bucket_versioning" {
  bucket = aws_s3_bucket.prod_bucket.id
  versioning_configuration {
    status = "Enabled" 
  }
}


# Create bucket ACL :
resource "aws_s3_bucket_acl" "prod_bucket_acl" {
  bucket = aws_s3_bucket.prod_bucket.id
  acl    = "private"
}

# Block public access :
resource "aws_s3_bucket_public_access_block" "prod_public_block" {
  bucket = aws_s3_bucket.prod_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

# Encrypt bucket using SSE-S3:
resource "aws_s3_bucket_server_side_encryption_configuration" "prod_encrypt" {
  bucket = aws_s3_bucket.prod_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Create S3 website hosting:
resource "aws_s3_bucket_website_configuration" "prod_website" {
  bucket = aws_s3_bucket.prod_bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# Add bucket policy to let the CloudFront OAI get objects:
resource "aws_s3_bucket_policy" "prod_bucket_policy" {
  bucket = aws_s3_bucket.prod_bucket.id
  policy = data.aws_iam_policy_document.prod_bucket_policy_document.json
}

/*
# Upload website files to S3:
resource "aws_s3_object" "prod_object" {
  bucket = aws_s3_bucket.prod_bucket.id

  for_each     = fileset("uploads/", "*")
  key          = "website/${each.value}"
  source       = "uploads/${each.value}"
  etag         = filemd5("uploads/${each.value}")
  content_type = "text/html"

  depends_on = [
    aws_s3_bucket.prod_bucket
  ]
}*/
