terraform {
  backend "s3" {
    bucket = "terraform-state-version-bucket-dev"
    key    = "cloudwatch-lambda/terraform.tfstate"
    region = "eu-west-2"
  }
}