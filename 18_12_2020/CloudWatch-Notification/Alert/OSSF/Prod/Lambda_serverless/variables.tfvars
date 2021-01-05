region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::131312303718:policy/DcpPermissionsBoundary"

aws_sg_id = "sg-0285a928f8e31e110"
vpc_id = "vpc-0930ba95bded494d0"
env = "Prod"
subnet_AZa_id = "subnet-09a56d6e2c97293d9"
subnet_AZb_id = "subnet-08d50815143383bcd"
subnet_AZc_id = "subnet-008751221d07c364b"

lambda-layer = "arn:aws:lambda:eu-west-2:131312303718:layer:request:1"
codepipeline_role_name= "lambda-ossf-Prod-cwalerts-pprole"
codebuild_role_name= "lambda-ossf-Prod-cwalerts-cbrole"
cloudformation_role_name= "lambda-ossf-Prod-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-ossf-Prod-cwalerts-role"

cloudformation_policy_name= "lambda-ossf-Prod-cwalerts-policy"
codepipeline_policy_name= "lambda-ossf-Prod-cwalerts-pp-policy"
code_build_policy_name= "lambda-ossf-Prod-cwalerts-cb-policy"
lambda_policy_name= "lambda-ossf-Prod-cwalerts-app-policy"

app_name= "CloudwatchAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-ossf-Prod-cwalerts-pp"
codebuild_project_name= "lambda-ossf-Prod-cwalerts-build"
sourcecode_bucket_name= "lambda-ossf-prod-cwalerts-bucket"

codecommit_stage_name= "lambda-ossf-Prod-cwalerts-commit"
codebuild_stage_name= "lambda-ossf-Prod-cwalerts-build"
codedeploy_stage_name= "lambda-ossf-Prod-cwalerts-deploy"
codeexecute_stage_name= "lambda-ossf-Prod-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"