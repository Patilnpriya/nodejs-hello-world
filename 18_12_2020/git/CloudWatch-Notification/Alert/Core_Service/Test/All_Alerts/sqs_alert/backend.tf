terraform {
  backend "s3" {
    bucket = "terraform-state-version-bucket-test"
    key    = "cloudwatchsqs/terraform.tfstate"
    region = "eu-west-2"
  }
}