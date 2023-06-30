variable "region" {
  default = "us-east-1"
}

variable "remote_state_bucket" {}
variable "remote_state_key" {}

variable "id_vpc_this_infra" {
}

variable "pair_key_name" {
  default = "TEST-ELVA-key"
}

variable "ubuntu_ami" {
  default = "ami-0261755bbcb8c4a84"
}

variable "type_instance" {
  default = "t2.micro"
}

variable "sg_public" {
}

variable "sg_private" {
}

variable "db_instance_class" {
  default = "db.t2.small"
}

variable "db_username" {
  description = "Username of db"
}

variable "db_password" {
  description = "Password of db"
}

variable "public_subnet_1_id"{}
variable "public_subnet_2_id"{}

variable "private_subnet_1_id"{}
variable "private_subnet_2_id"{}
variable "private_subnet_3_id"{}
