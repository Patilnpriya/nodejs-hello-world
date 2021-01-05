provider "aws" {
  region = var.region
}

resource "aws_iam_role" "codepipeline_role" {
  name = var.codepipeline_role_name
  permissions_boundary = var.permissions_boundary_arn
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags =  {
      Maintainer = var.app_maintainer
          Application = var.app_name
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = var.codepipeline_policy_name
  role = aws_iam_role.codepipeline_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:*",
                "s3:GetObjectVersion",
                "s3:GetBucketVersioning",
                "sts:AssumeRole",
                "cloudwatch:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::codepipeline*",
                "arn:aws:s3:::elasticbeanstalk*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "codecommit:CancelUploadArchive",
                "codecommit:GetBranch",
                "codecommit:GetCommit",
                "codecommit:GetUploadArchiveStatus",
                "codecommit:UploadArchive"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codedeploy:CreateDeployment",
                "codedeploy:GetApplicationRevision",
                "codedeploy:GetDeployment",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:RegisterApplicationRevision"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "ec2:*",
                "elasticloadbalancing:*",
                "autoscaling:*",
                "cloudwatch:*",
                "s3:*",
                "sns:*",
                "cloudformation:*",
                "sqs:*",
                "ecs:*",
                "iam:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "lambda:InvokeFunction",
                "lambda:ListFunctions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                        "codebuild:*",
                "codebuild:BatchGetBuilds",
                "codebuild:StartBuild"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_role_name
  permissions_boundary = var.permissions_boundary_arn
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags =  {
          Maintainer = var.app_maintainer
          Application = var.app_name
  }
}

resource "aws_iam_role_policy_attachment" "iam_code_build_policy_attach2" {
  #name= "AWSCodeBuildAdminAccess"
  role= aws_iam_role.codebuild_role.id
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}

resource "aws_iam_role_policy_attachment" "iam_code_build_policy_attach3" {
  #name= "EC2ContainerRegistry"
  role= aws_iam_role.codebuild_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "iam_code_build_policy_attach4" {
  #name= "EC2ContainerRegistry"
  role= aws_iam_role.codebuild_role.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_role_policy_attachment" "iam_code_build_policy_attach5" {
  #name= "EC2FullAccess"
  role= aws_iam_role.codebuild_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy" "code_build_policy" {
  name = var.code_build_policy_name
  role = aws_iam_role.codebuild_role.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "s3:*",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "AccessCodePipelineArtifacts"
    },
    {
      "Action": [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "AccessECR"
    },
    {
      "Action": [
          "ecr:GetAuthorizationToken"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "ecrAuthorization"
    },
    {
      "Action": [
          "ecs:RegisterTaskDefinition",
          "ecs:DescribeTaskDefinition",
          "ecs:DescribeServices",
          "ecs:CreateService",
          "ecs:ListServices",
          "ecs:UpdateService"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "ecsAccess"
    },
    {
         "Sid":"logStream",
         "Effect":"Allow",
         "Action":[
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
            "logs:CreateLogStream"
         ],
         "Resource":"arn:aws:logs:${var.region}:*:*"
    }
  ]
}
POLICY
}


resource "aws_iam_role" "cloudformation_role" {
  name = var.cloudformation_role_name
  permissions_boundary = var.permissions_boundary_arn
  assume_role_policy = <<EOF
{
        "Version": "2012-10-17",
        "Statement": [
                {
                        "Action": "sts:AssumeRole",
                        "Principal": {
                                "Service": "cloudformation.amazonaws.com"
                        },
                        "Effect": "Allow",
                        "Sid": ""
                }
        ]
}
EOF

  tags = {
          Maintainer = var.app_maintainer
          Application = var.app_name
  }
}

resource "aws_iam_role_policy_attachment" "lambda_execute" {
  role= aws_iam_role.cloudformation_role.id
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

resource "aws_iam_role_policy_attachment" "cf_sns" {
  role= aws_iam_role.cloudformation_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

resource "aws_iam_role_policy_attachment" "cf_cw" {
  role= aws_iam_role.cloudformation_role.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}
resource "aws_iam_role_policy_attachment" "cf_ec2" {
  role= aws_iam_role.cloudformation_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
resource "aws_iam_role_policy" "cloudformation_policy_name" {
  name = var.cloudformation_policy_name
  role = aws_iam_role.cloudformation_role.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
                {
                        "Action": [
                                "s3:GetObject",
                                "s3:GetObjectVersion",
                                "s3:GetBucketVersioning"
                        ],
                        "Resource": "*",
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "s3:PutObject"
                        ],
                        "Resource": [
                                "arn:aws:s3:::codepipeline*"
                        ],
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "lambda:*"
                        ],
                        "Resource": [
                                "*"
                        ],
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "apigateway:*"
                        ],
                        "Resource": [
                                "*"
                        ],
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "iam:GetRole",
                                "iam:CreateRole",
                                "iam:DeleteRole",
                                "iam:PutRolePolicy"
                        ],
                        "Resource": [
                                "*"
                        ],
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "iam:AttachRolePolicy",
                                "iam:DeleteRolePolicy",
                                "iam:DetachRolePolicy"
                        ],
                        "Resource": [
                                "*"
                        ],
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "iam:PassRole"
                        ],
                        "Resource": [
                                "*"
                        ],
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "cloudformation:CreateChangeSet"
                        ],
                        "Resource": [
                                "*"
                        ],
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "codedeploy:CreateApplication",
                                "codedeploy:DeleteApplication",
                                "codedeploy:RegisterApplicationRevision"
                        ],
                        "Resource": [
                                "*"
                        ],
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "codedeploy:CreateDeploymentGroup",
                                "codedeploy:CreateDeployment",
                                "codedeploy:GetDeployment"
                        ],
                        "Resource": [
                                "*"
                        ],
                        "Effect": "Allow"
                },
                {
                        "Action": [
                                "codedeploy:GetDeploymentConfig"
                        ],
                        "Resource": [
                                "*"
                        ],
                        "Effect": "Allow"
                }
   ]
}
POLICY
}

resource "aws_iam_role" "lambda_fuction_role" {
  name = var.lambdafucntion_role_name
  permissions_boundary = var.permissions_boundary_arn
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags =  {
      Maintainer = var.app_maintainer
          Application = var.app_name
  }
}

resource "aws_iam_role_policy_attachment" "lambda_ec2" {
  role= aws_iam_role.lambda_fuction_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_sns" {
  role= aws_iam_role.lambda_fuction_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_cw" {
  role= aws_iam_role.lambda_fuction_role.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

data "template_file" "buildspec" {
  template = file("buildspec.yml")
  vars = {
    artifact-bucket = var.sourcecode_bucket_name
    role = aws_iam_role.lambda_fuction_role.arn
    region = var.region
    lambda-layer = var.lambda-layer
  }
}

resource "aws_codebuild_project" "lambda_codebuild" {
  name              = var.codebuild_project_name
  description       = "AWS CodeBuild"
  build_timeout     = "300"
  service_role      = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type         = "LINUX_CONTAINER"
    privileged_mode = true
    }

  source {
    type            = "CODEPIPELINE"
    buildspec       = data.template_file.buildspec.rendered
  }
  cache {
    modes = [
       "LOCAL_DOCKER_LAYER_CACHE",
       "LOCAL_SOURCE_CACHE",
    ]
  type  = "LOCAL"
  }
  vpc_config {
    vpc_id = "${var.vpc_id}"

    subnets = [
      "${var.subnet_AZa_id}",
      "${var.subnet_AZb_id}",
      "${var.subnet_AZc_id}",
    ]
    security_group_ids = [
      "${var.aws_sg_id}"
    ]
  }
  tags =  {
      Maintainer = var.app_maintainer
          Application = var.app_name
  }
}
resource "aws_s3_bucket" "sourcecode_bucket" {
  bucket = var.sourcecode_bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  tags =  {
      Maintainer = var.app_maintainer
          Application = var.app_name
  }
}
resource "aws_codepipeline" "lambda_codepipeline" {
  name     = var.codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.sourcecode_bucket.bucket
    type     = "S3"
  }

  stage {
    name = var.codecommit_stage_name
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source"]

      configuration = {
        RepositoryName       = var.repo_name
        BranchName           = var.branch_name
      }
    }
  }

  stage {
    name = var.codebuild_stage_name
    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source"]
      output_artifacts= ["BuildArtifacts"]
      version         = "1"
      configuration = {
         ProjectName = aws_codebuild_project.lambda_codebuild.name
      }
    }
  }

  stage {
    name = var.codedeploy_stage_name

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["BuildArtifacts"]
      version         = "1"

      configuration = {
        ActionMode     = "CHANGE_SET_REPLACE"
        Capabilities   = "CAPABILITY_IAM"
        StackName      = "${var.app_name}-stack"
        ChangeSetName = "${var.app_name}-cs"
        RoleArn = aws_iam_role.cloudformation_role.arn
        TemplatePath   = "BuildArtifacts::outputSamTemplate.yaml"
      }
    }
  }
  stage {
    name = var.codeexecute_stage_name

    action {
      name            = "Execute"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["BuildArtifacts"]
      version         = "1"

      configuration = {
        ActionMode     = "CHANGE_SET_EXECUTE"
        StackName      = "${var.app_name}-stack"
        ChangeSetName = "${var.app_name}-cs"
        }
    }
  }


  tags =  {
      Maintainer = var.app_maintainer
          Application = var.app_name
  }
}