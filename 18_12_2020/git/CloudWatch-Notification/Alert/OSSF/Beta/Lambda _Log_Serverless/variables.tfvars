region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::408717978921:policy/DcpPermissionsBoundary"

aws_sg_id = "sg-005eaf4d5d29f5b33"
vpc_id = "vpc-0670e9b8b656bf614"
env = "beta"
subnet_AZa_id = "subnet-0637a5eca64c4c7b7"
subnet_AZb_id = "subnet-035b180bb58805cdf"
subnet_AZc_id = "subnet-0a1ba02aee39e807c"

lambda-layer = "arn:aws:lambda:eu-west-2:408717978921:layer:request:1"
codepipeline_role_name= "lambda-ossf-logbeta-cwalerts-pprole"
codebuild_role_name= "lambda-ossf-logbeta-cwalerts-cbrole"
cloudformation_role_name= "lambda-ossf-logbeta-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-ossf-logbeta-cwalerts-role"

cloudformation_policy_name= "lambda-ossf-logbeta-cwalerts-policy"
codepipeline_policy_name= "lambda-ossf-logbeta-cwalerts-pp-policy"
code_build_policy_name= "lambda-ossf-logbeta-cwalerts-cb-policy"
lambda_policy_name= "lambda-ossf-logbeta-cwalerts-app-policy"

app_name= "CloudwatchLogAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-ossf-logbeta-cwalerts-pp"
codebuild_project_name= "lambda-ossf-logbeta-cwalerts-build"
sourcecode_bucket_name= "lambda-ossf-logbeta-cwalerts-bucket"

codecommit_stage_name= "lambda-ossf-logbeta-cwalerts-commit"
codebuild_stage_name= "lambda-ossf-logbeta-cwalerts-build"
codedeploy_stage_name= "lambda-ossf-logbeta-cwalerts-deploy"
codeexecute_stage_name= "lambda-ossf-logbeta-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"