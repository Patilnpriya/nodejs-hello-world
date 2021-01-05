terraform {
  backend "s3" {
    bucket = "terraform-state-version-bucket"
    key    = "cloudwatchalert-new/terraform.tfstate"
    region = "eu-west-2"
  }
}