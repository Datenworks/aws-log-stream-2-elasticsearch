provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
}

##################
## DATA SECTION ##
##################
data "aws_caller_identity" "current" {}

data "external" "log_group_names_function" {
  program = ["python3", "${path.module}/lambda_logs_collector.py"]
  query = {
    group_names_list = "group_names"
  }
}

#####################
## MODULES SECTION ##
#####################

# ElasticSearch 
module "elasticsearch" {
  source = "../modules/elasticsearch-service"

  domain_name            = var.es_domain
  elasticsearch_version  = "7.4"
  ebs_volume_size        = var.ebs_volume_size
  instance_type          = var.instance_type
  instance_count         = var.instance_count
  zone_awareness_enabled = var.enable_ha

  encrypt_at_rest_enabled = true
  security_group_ids      = var.sg_ids
  subnet_ids              = var.subnet_ids

}

resource "aws_iam_policy" "elasticsearch" {
  name        = "AllowAccessToWriteOnElasticsearch"
  description = "Allow Logstash Task write on ElasticSearch service"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "es:ESHttpHead",
                "es:ESHttpPost",
                "es:ESHttpGet",
                "es:ESHttpPatch",
                "es:ESHttpPut"
            ],
            "Resource": "arn:aws:es:${var.region}:${data.aws_caller_identity.current.account_id}:domain/${var.es_domain}"
        }
    ]
}
EOF
}

##########################
## XRAY CONSUMER LAMBDA ##
##########################


module "cloudwatch_logs_to_es_lambda" {
  source = "../modules/lambda"

  s3_bucket = var.lambda_bucket
  s3_key    = var.lambda_key

  runtime          = "nodejs10.x"
  function_name    = "cloudwatch-logs-to-es"
  function_handler = "index.handler"
  function_memory  = 128
  function_timeout = 300

  subnet_ids         = var.subnet_ids
  security_group_ids = var.lambda_security_group_ids

  additional_policies = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::339307167654:policy/AllowAccessToWriteOnElasticsearch"]
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowCloudWatchLogs"
  action        = "lambda:InvokeFunction"
  function_name = module.cloudwatch_logs_to_es_lambda.arn
  principal     = "logs.${var.region}.amazonaws.com"
  source_arn    = "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*:*"
}

resource "aws_cloudwatch_log_subscription_filter" "lambdafunction_logfilter" {
  depends_on = [aws_lambda_permission.allow_cloudwatch]
  count      = length(split(",", data.external.log_group_names_function.result.group_names))

  name            = "stream-to-es"
  log_group_name  = split(",", data.external.log_group_names_function.result.group_names)[count.index]
  filter_pattern  = ""
  destination_arn = module.cloudwatch_logs_to_es_lambda.arn
}
