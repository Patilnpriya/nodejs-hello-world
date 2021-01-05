region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::201275825825:policy/DcpPermissionsBoundary"

aws_sg_id = "	sg-0df6b82a633617c43" 
vpc_id = "vpc-0e46039a96ce2ac92"  
env = "test"
subnet_AZa_id = "subnet-064e5ea16b476d49b"  
subnet_AZb_id = "subnet-0d2bead7af02100a8"  
subnet_AZc_id = "subnet-0b13d186d1a0e84de"  

lambda-layer = "arn:aws:lambda:eu-west-2:201275825825:layer:request:1"
codepipeline_role_name= "lambda-ossf-logtest-cwalerts-pprole"
codebuild_role_name= "lambda-ossf-logtest-cwalerts-cbrole"
cloudformation_role_name= "lambda-ossf-logtest-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-ossf-logtest-cwalerts-role"

cloudformation_policy_name= "lambda-ossf-logtest-cwalerts-policy"
codepipeline_policy_name= "lambda-ossf-logtest-cwalerts-pp-policy"
code_build_policy_name= "lambda-ossf-dev-cwalerts-cb-policy"
lambda_policy_name= "lambda-ossf-logtest-cwalerts-app-policy"

app_name= "CloudwatchLogAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-ossf-logtest-cwalerts-pp"
codebuild_project_name= "lambda-ossf-logtest-cwalerts-build"
sourcecode_bucket_name= "lambda-ossf-logtest-cwalerts-bucket"

codecommit_stage_name= "lambda-ossf-logtest-cwalerts-commit"
codebuild_stage_name= "lambda-ossf-logtest-cwalerts-build"
codedeploy_stage_name= "lambda-ossf-logtest-cwalerts-deploy"
codeexecute_stage_name= "lambda-ossf-logtest-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"