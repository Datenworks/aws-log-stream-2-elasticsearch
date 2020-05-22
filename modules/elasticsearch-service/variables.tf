variable "automated_snapshot_start_hour" {
  description = "Hora em que será executado o snapshot automático diário"
  default     = 23
}

variable "dedicated_master_count" {
  description = "Número de nós master dedicados"
  default     = 0
}

variable "dedicated_master_enabled" {
  description = "Habilita o provisionamento de nós master dedicados"
  default     = false
}

variable "dedicated_master_type" {
  description = "Tipo das instâncias dos nós dedicados"
  default     = ""
}

variable "domain_name" {
  description = "Nome do domínio para o cluster do Elasticsearch"
  default     = ""
}

variable "ebs_volume_size" {
  description = "Tamanho do disco da instância do Elasticsearch"
  default     = 80
}

variable "ebs_volume_type" {
  description = "Tipo do volume EBS"
  default     = "gp2"
}

variable "elasticsearch_version" {
  description = "Versão do Elasticsearch"
  default     = "6.4"
}

variable "encrypt_at_rest_enabled" {
  description = "Habilita criptografia de dados em repouso (dados salvos em mídias persistentes)"
  default     = false
}

variable "instance_count" {
  description = "Número de instâncias pertencentes ao domínio"
  default     = 1
}

variable "instance_type" {
  description = "Tipo das instâncias do domínio"
  default     = "m4.large.elasticsearch"
}

variable "security_group_ids" {
  description = "Lista com IDs dos security groups vinculados ao domínio"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Lista com IDs das subnets utilizadas pelas instâncias do domínio"
  type        = list(string)
}

variable "tags" {
  description = "Map de tags do domínio"
  default     = {}
}

variable "zone_awareness_enabled" {
  description = "Habilita o uso de múltiplas AZs"
  default     = false
}
