# aws-log-stream-2-elasticsearch

## Boilerplate for provisioning an LogStream data to ElasticsearchService 

### Requirements

```list
- terraform
- python3.x
- boto3 - python dependency
- Make GNU
```

### First of all

After install python3.x, on your terminal, apply
```bash
pip install boto3
```

Well, with this, we already have our unique external dependency installed.

With this applied, you will need to setup some variables on the terraform module in ``` infrastructure/variables.tf ```

# The Terraform module specification

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| external | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| ebs\_volume\_size | Ebs volume size to elasticsearch | `number` | n/a | yes |
| enable\_ha | Enable HA | `bool` | n/a | yes |
| env | Environment tag | `any` | n/a | yes |
| es\_domain | The Elasticsearch Service domain to store Cloudwatch Metrics | `string` | n/a | yes |
| instance\_count | Number of instances to be deployed | `number` | n/a | yes |
| instance\_type | Instance type for elasticsearch cluster | `string` | `"m4.large.elasticsearch"` | no |
| lambda\_bucket | The bucket to store the lambda code | `string` | n/a | yes |
| lambda\_key | The key yo store the lambda code | `string` | n/a | yes |
| lambda\_security\_group\_ids | security\_group\_ids for lambda | `list(string)` | n/a | yes |
| region | Provider Region | `any` | n/a | yes |
| sg\_ids | list of Security Group id to elasticsearch cluster | `list(string)` | n/a | yes |
| subnet\_ids | List of Subnet Ids to lambda and es service | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | Elastisearch service domain arn |
| domain\_id | Elasticsearch domain id |
| domain\_name | Elasticsearch domain name |
| endpoint | Elasticsearch domain endpoint |
| kibana\_endpoint | Elasticsearch KIBANA domain endpoint |


# To deploy

First you will need to zip the lambda code at ```./lambda/``` and cp to you AWS Bucket and Key of your preference.
Then after all, apply the terraform module at ```./infrastructure```.

[![DatenWorks](https://datenworks.com/wp-content/themes/datenworks/img/logo.png)](https://www.datenworks.com/)
