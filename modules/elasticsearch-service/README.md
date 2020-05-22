# Módulo Terraform - AWS - Elasticsearch Service

Módulo do Terraform para provisionamento de um domínio do Amazon Elasticsearch Service ([Amazon ES][elasticsearch-docs]).

[elasticsearch-docs]: https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/what-is-amazon-elasticsearch-service.html

## Uso

```hcl
module "elasticsearch" {
  source = "git::ssh://git@example.com/terraform-modules/aws/elasticsearch-service.git?ref=v0.5.0"

  domain_name = "elasticsearch-exemplo"

  security_group_ids = ["sg-abc123"]
  subnet_ids         = ["subnet-123456"]

  tags {
    Environment = "tf-testes"
    Terraform   = "true"
  }
}
```

## Recursos provisionados

- Elasticsearch Domain

## Customizações

### Número de instâncias

Use a variável `instance_count` para adicionar mais nós ao domínio:

```hcl
module "elasticsearch" {
  # ...

  instance_count = 2
}
```

### Nós dedicados

Para provisionar nós dedicados, use os parâmetros conforme exemplo abaixo:

```hcl
module "elasticsearch" {
  # ...

  dedicated_master_enabled = true
  dedicated_master_type    = "m4.large.elasticsearch"

  # NOTA: o mínimo deve ser 3
  dedicated_master_count = 3
}
```

### Zone awareness

Caso esteja usando mais de um nó, a variável `zone_awareness_enabled` pode ser habilitada
para maior disponibilidade do domínio:

```hcl
module "elasticsearch" {
  # ...

  dedicated_master_enabled = true
  dedicated_master_count   = 3

  zone_awareness_enabled = true
}
```

## Exemplos

- [Domínio básico do Elasticsearch Service](examples/basic-domain/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| security\_group\_ids | Lista com IDs dos security groups vinculados ao domínio | list | n/a | yes |
| subnet\_ids | Lista com IDs das subnets utilizadas pelas instâncias do domínio | list | n/a | yes |
| automated\_snapshot\_start\_hour | Hora em que será executado o snapshot automático diário | string | `"23"` | no |
| dedicated\_master\_count | Número de nós master dedicados | string | `"0"` | no |
| dedicated\_master\_enabled | Habilita o provisionamento de nós master dedicados | string | `"false"` | no |
| dedicated\_master\_type | Tipo das instâncias dos nós dedicados | string | `""` | no |
| domain\_name | Nome do domínio para o cluster do Elasticsearch | string | `""` | no |
| ebs\_volume\_size | Tamanho do disco da instância do Elasticsearch | string | `"80"` | no |
| ebs\_volume\_type | Tipo do volume EBS | string | `"gp2"` | no |
| elasticsearch\_version | Versão do Elasticsearch | string | `"6.4"` | no |
| encrypt\_at\_rest\_enabled | Habilita criptografia de dados em repouso (dados salvos em mídias persistentes) | string | `"false"` | no |
| instance\_count | Número de instâncias pertencentes ao domínio | string | `"1"` | no |
| instance\_type | Tipo das instâncias do domínio | string | `"m4.large.elasticsearch"` | no |
| tags | Map de tags do domínio | map | `{}` | no |
| zone\_awareness\_enabled | Habilita o uso de múltiplas AZs | string | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN do domínio |
| domain\_id | ID do domínio |
| domain\_name | Nome do domínio |
| endpoint | Endpoint do domínio |
| kibana\_endpoint | Endpoint do Kibana criado para o domínio |
| vpc\_availability\_zones | Lista de AZs da VPC usada pelo domínio |
| vpc\_id | ID da VPC usada pelo domínio |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
