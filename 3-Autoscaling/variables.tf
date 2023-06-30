variable "region" {
  default = "us-east-1"
}

variable "remote_state_bucket" {}
variable "remote_state_key" {}

variable "sg_public" {
}

variable "sg_private" {
}

variable "public_subnet_1_id"{}
variable "public_subnet_2_id"{}

variable "private_subnet_1_id"{}
variable "private_subnet_2_id"{}
variable "private_subnet_3_id"{}

variable "id_image"{
    default = "ami-0261755bbcb8c4a84"
}

variable "type_instance" {
  default = "t2.micro"
}

variable "name_key"{
    default = "TEST-ELVA-key"
}