#### basic ######
aws_region = "us-east-1"
enviroment = "production"
managed_by = "Terraform"
project    = "project-sarkar"

###### S3-Bucket #########
s3_prod_bucket_artifact_deploy    = "my-production-bucket-sarkar-terraform-cldfrnt"
codepipeline_artifact_bucket_name = "my-codepipeline-artifact-sarkar-terraform-cldfrnt"
s3_object_expiration_days         = "60"

#######Aws-pipeline #######
pipeline-name = "test-terraform"
## source-stage ##
connection_arn = "arn:aws:codestar-connections:us-east-1:479591652716:connection/6d08024f-517e-44ce-a6a8-65fe46e0f3ce"
repository_id  = "bsarkar1990/cloud-front-test"
branch_name    = "master"

## Deploy-stage ##
object_key = "new-sark-bucket.zip"

## Invalidate-stage ##
invalidate_region = "us-east-1"
invalidate_name   = "Invalidate"

#####Lambda ######
source_file_name     = "index.py"
lambda_function_name = "test-function"

#######Cloudfront ####
cloud_distribution_comment = "Production distribution"
cloudfront_allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
cloudfront_cached_methods  = ["GET", "HEAD", "OPTIONS"]