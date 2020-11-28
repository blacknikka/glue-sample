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

  bucket_name = "${var.base_name}-etl-target-bucket"
}

module "ec2" {
  source = "./modules/ec2"

  base_name      = var.base_name
  vpc_main       = module.network.vpc_main
  subnet_for_app = module.network.subnet_for_app
}

module "rds" {
  source = "./modules/rds"

  db_name      = "target-db"
  vpc_main     = module.network.vpc_main
  rds_subnet_1 = module.network.subnet_for_app
  rds_subnet_2 = module.network.subnet_for_app2
  source_security_group_ids = [
    module.ec2.security_group_for_app.id
  ]
}
