resource "aws_codepipeline" "codepipeline" {
  name     = var.pipeline-name
  role_arn = data.aws_iam_role.codepipeline_role.arn
  //role_arn = data.aws_iam_role.iam_role_codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_artifact_bucket.id
    type     = "S3"
  }
  ################################################################
  ## Source Stage
  ################################################################
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = var.connection_arn
        FullRepositoryId = var.repository_id
        BranchName       = var.branch_name
      }
    }
  }
  ################################################################
  ## Build Stage
  ################################################################
  /*stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      configuration = {
        ProjectName = local.pipeline-name
      }
    }
  }
  */
  ################################################################
  ## Deploy Stage
  ################################################################
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["SourceArtifact"]
      version         = "1"

      configuration = {
        BucketName = aws_s3_bucket.prod_bucket.id
        ObjectKey  = var.object_key
        Extract    = "true"
      }
    }
  }

  ################################################################
  ## Invalidate Stage
  ################################################################
  stage {
    name = "invalidate"

    action {
      name            = var.invalidate_name
      category        = "Invoke"
      owner           = "AWS"
      provider        = "Lambda"
      region          = var.invalidate_region
      input_artifacts = ["SourceArtifact"]
      version         = "1"

      configuration = {
        FunctionName = aws_lambda_function.test-function.id
        //FunctionName   = data.aws_lambda_function.function-name.id
        UserParameters = "{\"distributionId\": ${jsonencode(aws_cloudfront_distribution.prod_cf_dist.id)}, \"objectPaths\": [\"/*\"]}"

      }
    }
  }
}    