
region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::294773374473:policy/DcpPermissionsBoundary"

aws_sg_id = "sg-05aece6a9901ef3ab"
vpc_id = "vpc-0491950e599a48f7a"
env = "beta"
subnet_AZa_id = "subnet-04d8004ee5ac77bfe"
subnet_AZb_id = "subnet-04607b163f0565641"
subnet_AZc_id = "subnet-00724f9173da8f187"

lambda-layer = "arn:aws:lambda:eu-west-2:294773374473:layer:request:1"
codepipeline_role_name= "lambda-core-logbeta-cwalerts-pprole"
codebuild_role_name= "lambda-core-logbeta-cwalerts-cbrole"
cloudformation_role_name= "lambda-core-logbeta-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-core-logbeta-cwalerts-role"

cloudformation_policy_name= "lambda-core-logbeta-cwalerts-policy"
codepipeline_policy_name= "lambda-core-logbeta-cwalerts-pp-policy"
code_build_policy_name= "lambda-core-logbeta-cwalerts-cb-policy"
lambda_policy_name= "lambda-core-logbeta-cwalerts-app-policy"

app_name= "CloudwatchLogAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-core-logbeta-cwalerts-pp"
codebuild_project_name= "lambda-core-logbeta-cwalerts-build"
sourcecode_bucket_name= "lambda-core-logbeta-cwalerts-bucket"

codecommit_stage_name= "lambda-core-logbeta-cwalerts-commit"
codebuild_stage_name= "lambda-core-logbeta-cwalerts-build"
codedeploy_stage_name= "lambda-core-logbeta-cwalerts-deploy"
codeexecute_stage_name= "lambda-core-logbeta-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"