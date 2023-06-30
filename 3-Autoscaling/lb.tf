#AWS provider and region

provider "aws" {
  region = var.region
}

#Inicialization of backend with autoscaling-prod.config
terraform {
  backend "s3" {

  }
}

#Inicialization of precios state of backend obtained from the previos instances-services layer.
data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
    region = "${var.region}"
    bucket = "${var.remote_state_bucket}"
    key    = "${var.remote_state_key}"
  }
}


#Classic load balancer that will controll traffic to autoscaling machines 
resource "aws_elb" "test_elva_elb" {
  name = "test-elva-elb"

  security_groups = [
    "${var.sg_public}"
  ]

  subnets = [
    "${var.private_subnet_1_id}",
    "${var.private_subnet_3_id}",
    "${var.public_subnet_2_id}",
  ]

  cross_zone_load_balancing = true

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 30
    interval            = 60
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}

#Launch template. It is needed to create machines that run nginx service using whelcome.sh file
resource "aws_launch_template" "test_elva_launch_template" {
  name                   = "test-elva-launch-configuration"
  image_id               = var.id_image
  instance_type          = var.type_instance
  key_name               = var.name_key
  vpc_security_group_ids = [var.sg_private]
  user_data              = base64encode(file("welcome.sh"))


  lifecycle {
    create_before_destroy = true
  }

}

