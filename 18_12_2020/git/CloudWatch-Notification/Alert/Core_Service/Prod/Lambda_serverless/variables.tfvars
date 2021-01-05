region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::695171761367:policy/DcpPermissionsBoundary"

aws_sg_id = "sg-006e4488a0fad3697"
vpc_id = "vpc-07d83526afbb0f299"
env = "prod"
subnet_AZa_id = "subnet-0643946773b9def0f"
subnet_AZb_id = "subnet-0e0900b5973674102"
subnet_AZc_id = "subnet-075fd0fc98124d172"

lambda-layer = "arn:aws:lambda:eu-west-2:695171761367:layer:request:1"
codepipeline_role_name= "lambda-core-prod-cwalerts-pprole"
codebuild_role_name= "lambda-core-prod-cwalerts-cbrole"
cloudformation_role_name= "lambda-core-prod-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-core-prod-cwalerts-role"

cloudformation_policy_name= "lambda-core-prod-cwalerts-policy"
codepipeline_policy_name= "lambda-core-prod-cwalerts-pp-policy"
code_build_policy_name= "lambda-core-prod-cwalerts-cb-policy"
lambda_policy_name= "lambda-core-prod-cwalerts-app-policy"

app_name= "CloudwatchAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-core-prod-cwalerts-pp"
codebuild_project_name= "lambda-core-prod-cwalerts-build"
sourcecode_bucket_name= "lambda-core-prod-cwalerts-bucket"

codecommit_stage_name= "lambda-core-prod-cwalerts-commit"
codebuild_stage_name= "lambda-core-prod-cwalerts-build"
codedeploy_stage_name= "lambda-core-prod-cwalerts-deploy"
codeexecute_stage_name= "lambda-core-prod-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"