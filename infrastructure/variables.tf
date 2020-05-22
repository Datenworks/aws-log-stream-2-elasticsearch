variable "region" {
  description = "Provider Region"
}

variable "env" {
  description = "Environment tag"
}

variable "instance_type" {
  description = "Instance type for elasticsearch cluster"
  default     = "m4.large.elasticsearch"
  type        = string
}

variable "instance_count" {
  type        = number
  description = "Number of instances to be deployed"
}

variable "sg_ids" {
  type        = list(string)
  description = "list of Security Group id to elasticsearch cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of Subnet Ids to lambda and es service"
}

variable "ebs_volume_size" {
  type        = number
  description = "Ebs volume size to elasticsearch "
}

variable "enable_ha" {
  type        = bool
  description = "Enable HA"
}

variable "es_domain" {
  description = "The Elasticsearch Service domain to store Cloudwatch Metrics"
  type        = string
}

variable "lambda_bucket" {
  type        = string
  description = "The bucket to store the lambda code"
}

variable "lambda_key" {
  type        = string
  description = "The key yo store the lambda code"
}


variable "lambda_security_group_ids" {
  description = "security_group_ids for lambda"
  type        = list(string)
}

