output "lb_url" {
  value = aws_elb.test_elva_elb.dns_name
}

output "lb_arn" {
  value = aws_elb.test_elva_elb.arn
}