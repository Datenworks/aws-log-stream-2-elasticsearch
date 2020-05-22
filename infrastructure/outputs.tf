output "arn" {
  description = "Elastisearch service domain arn"
  value       = module.elasticsearch.arn
}

output "domain_id" {
  description = "Elasticsearch domain id"
  value       = module.elasticsearch.domain_id
}

output "domain_name" {
  description = "Elasticsearch domain name"
  value       = module.elasticsearch.domain_name
}

output "endpoint" {
  description = "Elasticsearch domain endpoint"
  value       = module.elasticsearch.endpoint
}

output "kibana_endpoint" {
  description = "Elasticsearch KIBANA domain endpoint"
  value       = module.elasticsearch.kibana_endpoint
}
