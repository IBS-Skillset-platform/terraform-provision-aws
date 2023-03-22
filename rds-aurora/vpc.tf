# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
# allow the ec2 instances (endorsed by the security group `aws_security_group.instance`) to
# be connected with the rds postgreSQL instance (allow inbound port 5432)
/*resource "aws_security_group_rule" "postgresql_ec2_instances_sg" {
  # this rule is added to the security group defined by `security_group_id`
  # and this id target the `default` security group associated with the created VPC
  security_group_id = var.sec_group_id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432

  # One of ['cidr_blocks', 'ipv6_cidr_blocks', 'self', 'source_security_group_id', 'prefix_list_ids']
  # must be set to create an AWS Security Group Rule
  source_security_group_id = var.sec_group_id

  lifecycle {
    create_before_destroy = true
  }
}
*/