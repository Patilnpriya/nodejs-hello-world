
region = "eu-west-2"
permissions_boundary_arn = "arn:aws:iam::942944832559:policy/DcpPermissionsBoundary"

lambda-layer = "arn:aws:lambda:eu-west-2:942944832559:layer:request:1"
aws_sg_id = "sg-020af548d74efe1e1"
vpc_id = "vpc-03a4dcfcc65f32fa5"
env = "dev"
subnet_AZa_id = "subnet-0554b03953cda2bde"
subnet_AZb_id = "subnet-0b8354922f4a6ecb1"
subnet_AZc_id = "subnet-086ace6b412f94d05"

lambda-layer = "arn:aws:lambda:eu-west-2:942944832559:layer:request:1"
codepipeline_role_name= "lambda-ossf-dev-log-cwalerts-pprole"
codebuild_role_name= "lambda-ossf-dev-log-cwalerts-cbrole"
cloudformation_role_name= "lambda-ossf-dev-log-cwalerts-cfrole"
lambdafucntion_role_name= "lambda-ossf-dev-log-cwalerts-role"

cloudformation_policy_name= "lambda-ossf-dev-log-cwalerts-policy"
codepipeline_policy_name= "lambda-ossf-dev-log-cwalerts-pp-policy"
code_build_policy_name= "lambda-ossf-dev-log-cwalerts-cb-policy"
lambda_policy_name= "lambda-ossf-dev-log-cwalerts-app-policy"

app_name= "CloudwatchDevLogAlerts"
app_maintainer= "DevOps"

codepipeline_name= "lambda-ossf-dev-log-cwalerts-pp"
codebuild_project_name= "lambda-ossf-dev-log-cwalerts-build"
sourcecode_bucket_name= "lambda-ossf-dev-log-cwalerts-bucket"

codecommit_stage_name= "lambda-ossf-dev-log-cwalerts-commit"
codebuild_stage_name= "lambda-ossf-dev-log-cwalerts-build"
codedeploy_stage_name= "lambda-ossf-dev-log-cwalerts-deploy"
codeexecute_stage_name= "lambda-ossf-dev-log-cwalerts-execute"

repo_name= "core-infra"
branch_name= "cloudwatch"