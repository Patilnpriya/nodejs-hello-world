terraform {
  backend "s3" {
    bucket = "terraform-state-version-bucket-beta"
    key    = "cloudwatch-lambda/terraform.tfstate"
    region = "eu-west-2"
  }
}