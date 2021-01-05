region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::201275825825:policy/DcpPermissionsBoundary"

aws_sg_id = "	sg-0df6b82a633617c43" 
vpc_id = "vpc-0e46039a96ce2ac92"  
env = "test"
subnet_AZa_id = "subnet-064e5ea16b476d49b"  
subnet_AZb_id = "subnet-0d2bead7af02100a8"  
subnet_AZc_id = "subnet-0b13d186d1a0e84de"  

lambda-layer = "arn:aws:lambda:eu-west-2:201275825825:layer:request:1"
codepipeline_role_name= "lambda-core-test-cwalerts-pprole"
codebuild_role_name= "lambda-core-test-cwalerts-cbrole"
cloudformation_role_name= "lambda-core-test-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-core-test-cwalerts-role"

cloudformation_policy_name= "lambda-core-test-cwalerts-policy"
codepipeline_policy_name= "lambda-core-test-cwalerts-pp-policy"
code_build_policy_name= "lambda-core-dev-cwalerts-cb-policy"
lambda_policy_name= "lambda-core-test-cwalerts-app-policy"

app_name= "CloudwatchAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-core-test-cwalerts-pp"
codebuild_project_name= "lambda-core-test-cwalerts-build"
sourcecode_bucket_name= "lambda-core-test-cwalerts-bucket"

codecommit_stage_name= "lambda-core-test-cwalerts-commit"
codebuild_stage_name= "lambda-core-test-cwalerts-build"
codedeploy_stage_name= "lambda-core-test-cwalerts-deploy"
codeexecute_stage_name= "lambda-core-test-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"