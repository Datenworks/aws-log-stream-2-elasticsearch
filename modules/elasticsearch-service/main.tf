# ----------------------------------------------------------------------------------------------------------------------
# Elasticsearch Domain
# ----------------------------------------------------------------------------------------------------------------------

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  encrypt_at_rest {
    enabled = var.encrypt_at_rest_enabled
  }

  cluster_config {
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_type    = var.dedicated_master_type
    zone_awareness_enabled   = var.zone_awareness_enabled
  }

  vpc_options {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }
  
  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }
  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*"
        }
    ]
}
CONFIG
  tags = var.tags
  
  depends_on = [
    "aws_iam_service_linked_role.es",
  ]
}

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}