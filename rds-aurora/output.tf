output "ec2_public_dns" {
  value = aws_instance.instance.public_dns
}

output "latest_amazon_linux_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "db_instance_endpoint" {
  value = aws_rds_cluster.cluster.endpoint
}

output "ec2_subnet_id" {
  value = var.IBS-RnD-Sub1
}