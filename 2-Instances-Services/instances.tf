
#AWS provider and region
provider "aws" {
  region = var.region
}

#Inicialization of backend with instances-services-prod.config
terraform {
  backend "s3" {

  }
}

#Inicialization of precios state of backend obtained from the previos cloud-network layer.
data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
    region = "${var.region}"
    bucket = "${var.remote_state_bucket}"
    key    = "${var.remote_state_key}"
  }
}

#Key par needed to associate and get inside of EC2 machines
resource "aws_key_pair" "key-pair" {
  key_name   = var.pair_key_name
  public_key = file("${path.module}/id_rsa.pub")
}

#Creation of bastion server to configure diferent machines or databases inside our private subnets
resource "aws_instance" "ec2-bastion" {
  ami                         = var.ubuntu_ami
  instance_type               = var.type_instance
  subnet_id                   = var.public_subnet_1_id
  key_name                    = aws_key_pair.key-pair.key_name
  availability_zone           = "us-east-1a"
  vpc_security_group_ids      = [var.sg_public]
  associate_public_ip_address = true

  tags = {
    Name = "TEST-ELVA-BASTION-EC2"
  }
}

