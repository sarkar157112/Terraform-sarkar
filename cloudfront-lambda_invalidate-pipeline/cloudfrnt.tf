#creating OAI :
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${var.domain_name}"
}

resource "aws_cloudfront_distribution" "prod_cf_dist" {
  enabled = true
  //aliases             = [var.domain_name]
  comment             = var.cloud_distribution_comment
  default_root_object = "index.html"
  depends_on          = [aws_lambda_function.test-function]


  origin {
    domain_name = aws_s3_bucket.prod_bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.prod_bucket.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }
  default_cache_behavior {
    allowed_methods        = var.cloudfront_allowed_methods
    cached_methods         = var.cloudfront_cached_methods
    target_origin_id       = aws_s3_bucket.prod_bucket.id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      headers      = []
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      //restriction_type = "none"
      locations = ["US", "IN", "CA"]
    }
  }

  tags = {
    "Project"    = var.project
    "ManagedBy"  = var.managed_by
    "Enviroment" = var.enviroment
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}