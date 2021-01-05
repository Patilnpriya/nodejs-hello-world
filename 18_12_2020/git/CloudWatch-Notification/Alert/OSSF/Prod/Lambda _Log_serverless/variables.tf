varvariable "region" {
  default = "eu-west-2"
}

variable "permissions_boundary_arn" {}

variable "aws_sg_id" {}
variable "env" {}
variable "subnet_AZa_id" {}
variable "subnet_AZb_id" {}
variable "subnet_AZc_id" {}
variable "vpc_id" {}
variable "lambda-layer" {}
variable "codepipeline_role_name" {}
variable "codebuild_role_name" {}
variable "cloudformation_role_name" {}
variable "lambdafucntion_role_name" {}

variable "cloudformation_policy_name" {}
variable "codepipeline_policy_name" {}
variable "code_build_policy_name" {}
variable "lambda_policy_name" {}

variable "app_name" {}
variable "app_maintainer" {}

variable "codepipeline_name" {}
variable "codebuild_project_name" {}
variable "sourcecode_bucket_name" {}

variable "codecommit_stage_name" {}
variable "codebuild_stage_name" {}
variable "codedeploy_stage_name" {}
variable "codeexecute_stage_name" {}

variable "repo_name" {}
variable "branch_name" {}