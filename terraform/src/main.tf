terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    region  = "ap-northeast-1"
    encrypt = true

    bucket = "terraform-bucket-for-tfstate"
    key    = "glue-sample-terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "./modules/network"

  base_name = var.base_name
}

module "s3" {
  source = "./modules/s3"

  app_name = var.base_name
}
