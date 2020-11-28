variable "db_name" {}

variable "vpc_main" {}
variable "rds_subnet_1" {}
variable "rds_subnet_2" {}

variable "source_security_group_ids" {
  type = list(string)
}
