terraform {
  required_version = "~> 1.4.0"
}

locals {
  domain        = "opensearch-terraforrm"
  master_user   = "admin"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


resource "aws_opensearch_domain" "opensearch" {
  domain_name    = local.domain
  engine_version = "OpenSearch_${var.engine_version}"

  cluster_config {
       dedicated_master_count   = var.dedicated_master_count
       dedicated_master_type    = var.dedicated_master_type
       dedicated_master_enabled = var.dedicated_master_enabled
       instance_type            = var.instance_type
       instance_count           = var.instance_count
       zone_awareness_enabled   = var.zone_awareness_enabled
       zone_awareness_config {
         availability_zone_count = var.zone_awareness_enabled ? 3 : null
       }
  }


  advanced_security_options {
    enabled                        = var.security_options_enabled
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = local.master_user
      master_user_password = "Admin@123"
    }
  }

  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_size = var.ebs_volume_size
    volume_type = var.volume_type
    throughput  = var.throughput
  }

  node_to_node_encryption {
    enabled = true
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${local.domain}/*"
        }
    ]
}
CONFIG
}
