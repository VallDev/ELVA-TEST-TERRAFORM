output "public_ip_bastion" {
  value = aws_instance.ec2-bastion.public_ip
}

output "name_key" {
  value = aws_key_pair.key-pair.key_name
  
}

output "db_hostname" {
  value = aws_db_instance.test-elva-db.address
}

output "db_port" {
  value = aws_db_instance.test-elva-db.port
}

