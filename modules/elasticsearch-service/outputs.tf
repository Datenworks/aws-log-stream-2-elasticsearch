output "arn" {
  description = "ARN do domínio"
  value       = "${aws_elasticsearch_domain.elasticsearch.arn}"
}

output "domain_id" {
  description = "ID do domínio"
  value       = "${aws_elasticsearch_domain.elasticsearch.domain_id}"
}

output "domain_name" {
  description = "Nome do domínio"
  value       = "${aws_elasticsearch_domain.elasticsearch.domain_name}"
}

output "endpoint" {
  description = "Endpoint do domínio"
  value       = "${aws_elasticsearch_domain.elasticsearch.endpoint}"
}

output "kibana_endpoint" {
  description = "Endpoint do Kibana criado para o domínio"
  value       = "${aws_elasticsearch_domain.elasticsearch.kibana_endpoint}"
}

output "vpc_availability_zones" {
  description = "Lista de AZs da VPC usada pelo domínio"
  value       = "${aws_elasticsearch_domain.elasticsearch.vpc_options.0.availability_zones}"
}

output "vpc_id" {
  description = "ID da VPC usada pelo domínio"
  value       = "${aws_elasticsearch_domain.elasticsearch.vpc_options.0.vpc_id}"
}
