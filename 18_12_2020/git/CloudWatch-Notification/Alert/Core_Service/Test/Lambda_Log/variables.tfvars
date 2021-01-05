region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::898900948160:policy/DcpPermissionsBoundary"

aws_sg_id = "sg-0dfa0114563045241" 
vpc_id = "vpc-0179b227797ff7f87"  
env = "Test"
subnet_AZa_id = "subnet-0d5b3eaa8716941e6"  
subnet_AZb_id = "subnet-0d7eb03d47f1718f5"  
subnet_AZc_id = "subnet-03519d573ddd2b9b4"  

lambda-layer = "arn:aws:lambda:eu-west-2:898900948160:layer:request:1"
codepipeline_role_name= "lambda-test-cwalerts-pprole"
codebuild_role_name= "lambda-test-cwalerts-cbrole"
cloudformation_role_name= "lambda-test-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-test-cwalerts-role"

cloudformation_policy_name= "lambda-test-cwalerts-policy"
codepipeline_policy_name= "lambda-test-cwalerts-pp-policy"
code_build_policy_name= "lambda-test-cwalerts-cb-policy"
lambda_policy_name= "lambda-test-cwalerts-app-policy"

app_name= "CloudwatchAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-test-cwalerts-pp"
codebuild_project_name= "lambda-test-cwalerts-build"
sourcecode_bucket_name= "lambda-test-cwalerts-bucket"

codecommit_stage_name= "lambda-test-cwalerts-commit"
codebuild_stage_name= "lambda-test-cwalerts-build"
codedeploy_stage_name= "lambda-test-cwalerts-deploy"
codeexecute_stage_name= "lambda-test-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"