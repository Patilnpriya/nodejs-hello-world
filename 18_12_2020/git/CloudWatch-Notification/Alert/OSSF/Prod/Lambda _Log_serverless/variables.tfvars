region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::131312303718:policy/DcpPermissionsBoundary"

aws_sg_id = "sg-0285a928f8e31e110"
vpc_id = "vpc-0930ba95bded494d0"
env = "prod"
subnet_AZa_id = "subnet-09a56d6e2c97293d9"
subnet_AZb_id = "subnet-08d50815143383bcd"
subnet_AZc_id = "subnet-008751221d07c364b"

lambda-layer = "arn:aws:lambda:eu-west-2:131312303718:layer:request:1"
codepipeline_role_name= "lambda-ossf-logprod-cwalerts-pprole"
codebuild_role_name= "lambda-ossf-logprod-cwalerts-cbrole"
cloudformation_role_name= "lambda-ossf-logprod-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-ossf-logprod-cwalerts-role"

cloudformation_policy_name= "lambda-ossf-logprod-cwalerts-policy"
codepipeline_policy_name= "lambda-ossf-logprod-cwalerts-pp-policy"
code_build_policy_name= "lambda-ossf-logprod-cwalerts-cb-policy"
lambda_policy_name= "lambda-ossf-logprod-cwalerts-app-policy"

app_name= "CloudwatchLogAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-ossf-logprod-cwalerts-pp"
codebuild_project_name= "lambda-ossf-logprod-cwalerts-build"
sourcecode_bucket_name= "lambda-ossf-logprod-cwalerts-bucket"

codecommit_stage_name= "lambda-ossf-logprod-cwalerts-commit"
codebuild_stage_name= "lambda-ossf-logprod-cwalerts-build"
codedeploy_stage_name= "lambda-ossf-logprod-cwalerts-deploy"
codeexecute_stage_name= "lambda-ossf-logprod-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"