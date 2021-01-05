terraform {
  backend "s3" {
    bucket = "terraform-state-version-bucket-test"
    key    = "cloudwatch/terraform.tfstate"
    region = "eu-west-2"
  }
}