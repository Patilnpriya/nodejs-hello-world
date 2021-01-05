region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::016818321538:policy/DcpPermissionsBoundary"

aws_sg_id = "sg-024b306b574c2b2f4"
vpc_id = "vpc-0329a2afd8ed5c7b4"
env = "Dev"
subnet_AZa_id = "subnet-02a9909334108e5d5"
subnet_AZb_id = "subnet-0b3926e48d57ae415"
subnet_AZc_id = "subnet-03addd5106f26f488"

lambda-layer = "arn:aws:lambda:eu-west-2:016818321538:layer:request:1"
codepipeline_role_name= "lambda-core-logdev-cwalerts-pprole"
codebuild_role_name= "lambda-core-logdev-cwalerts-cbrole"
cloudformation_role_name= "lambda-core-logdev-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-core-logdev-cwalerts-role"

cloudformation_policy_name= "lambda-core-logdev-cwalerts-policy"
codepipeline_policy_name= "lambda-core-logdev-cwalerts-pp-policy"
code_build_policy_name= "lambda-core-logdev-cwalerts-cb-policy"
lambda_policy_name= "lambda-core-logdev-cwalerts-app-policy"

app_name= "CloudwatchLogAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-core-logdev-cwalerts-pp"
codebuild_project_name= "lambda-core-logdev-cwalerts-build"
sourcecode_bucket_name= "lambda-core-logdev-cwalerts-bucket"

codecommit_stage_name= "lambda-core-logdev-cwalerts-commit"
codebuild_stage_name= "lambda-core-logdev-cwalerts-build"
codedeploy_stage_name= "lambda-core-logdev-cwalerts-deploy"
codeexecute_stage_name= "lambda-core-logdev-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"


