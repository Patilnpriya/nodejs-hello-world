terraform {
  backend "s3" {
    bucket = "terraform-state-version-bucket-test"
    key    = "cloudwatchalert/terraform.tfstate"
    region = "eu-west-2"
  }
}