terraform {
  backend "s3" {
    bucket = "terraform-state-version-bucket-prod"
    key    = "cloudwatch-log/terraform.tfstate"
    region = "eu-west-2"
  }
}