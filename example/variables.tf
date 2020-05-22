variable "region" {
  description = "Provider Region"
  default     = "us-east-1"
}

variable "env" {
  description = "Environment tag"
  default     = "dev"
}

variable "instance_type" {
  description = "Instance type for elasticsearch cluster"
  default     = "m4.large.elasticsearch"
}

variable "instance_count" {
  type        = number
  description = "Number of instances to be deployed"
  default     = 4
}

variable "sg_ids" {
  type        = list(string)
  description = "list of Security Group id to elasticsearch cluster"
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of Subnet Ids to lambda and es service"
  default     = ["subnet-id-1", "subnet-id-2"]
}

variable "ebs_volume_size" {
  type        = number
  default     = 100
  description = "Ebs volume size to elasticsearch "
}

variable "enable_ha" {
  type        = bool
  value       = true
  description = "Enable HA"
}

variable "es_domain" {
  default     = "example-elasticsearch-service"
  description = "The Elasticsearch Service domain to store Cloudwatch Metrics"
  type        = string
}

variable "lambda_bucket" {
  default     = "your-bucket"
  type        = string
  description = "The bucket to store the lambda code"
}

variable "lambda_key" {
  default     = "path/to/your/lambda"
  type        = string
  description = "The key yo store the lambda code"
}


variable "lambda_security_group_ids" {
  default = []
  description = "security_group_ids for lambda"
  type        = list(string)
}

