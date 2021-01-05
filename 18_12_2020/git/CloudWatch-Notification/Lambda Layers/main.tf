provider "aws" {
  region = var.region
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = var.filename
  layer_name = var.layername

  compatible_runtimes = [var.runtime]
}