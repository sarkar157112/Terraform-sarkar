####### s3-prod-bucket ###########
variable "s3_prod_bucket_artifact_deploy" {
  description = "The name of the production S3 bucket for artifact deployment."
  type        = string
}

variable "codepipeline_artifact_bucket_name" {
  description = "The name of the S3 bucket for storing CodePipeline artifacts at the production level."
  type        = string
}


variable "s3_object_expiration_days" {
  description = "Number of days after which S3 bucket objects will expire"
  type        = number
  default     = 30
}

############## ###################
variable "aws_region" {
  description = "The AWS region where resources should be created."
  type        = string
  default     = "us-east-1"
}

variable "enviroment" {
  description = "The name of the enviroment."
  type        = string
}

variable "managed_by" {
  description = "The name who is mannaged. such us Terraform."
  type        = string
}

variable "project" {
  description = "The name of the project."
  type        = string
}

######## cloudfront ###########
variable "domain_name" {
  type        = string
  description = "The domain name to use"
  default     = "bsarkar.com"
}


variable "cloud_distribution_comment" {
  type        = string
  description = "The name of the cloud distribution"
  default     = "invalidate"
}

variable "cloudfront_allowed_methods" {
  type        = list(string)
  description = "The allowed HTTP methods for the CloudFront distribution"
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cloudfront_cached_methods" {
  type        = list(string)
  description = "The cached HTTP methods for the CloudFront distribution"
  default     = ["GET", "HEAD", "OPTIONS"]
}

########### Pipeline #########


variable "pipeline-name" {
  description = "The name of the AWS pipeline."
  type        = string
}

## source-stage ##
variable "connection_arn" {
  type        = string
  description = "The ARN of the CodeStar connection to use"
}

variable "repository_id" {
  type        = string
  description = "The full ID of the CodeCommit repository"
}

variable "branch_name" {
  type        = string
  description = "The name of the branch to use"
}



variable "object_key" {
  description = "The name of the AWS pipeline-deploy object key. This is because the AWS CodeCommit action in your pipeline zips source artifacts and your file is a ZIP file."
  type        = string
}

variable "invalidate_region" {
  description = "The AWS region where invalidate should be created."
  type        = string
  default     = "us-east-1"
}

variable "invalidate_name" {
  description = "The name of the invalidate should be created."
  type        = string
}

########## Lambda ############
variable "lambda_function_name" {
  description = "The name of the function."
  type        = string
}

variable "source_file_name" {
  description = "The name of the python-script."
  type        = string
}