variable "s3_bucket" {
  description = "S3 Bucket of .zip lambda package"
  type        = string
}

variable "s3_key" {
  description = "S3 Path for the .zip package of the lambda"
  type        = string
}

variable "function_name" {
  description = "Lambda Function name"
  type        = string
}

variable "function_handler" {
  description = "Lambda Function execution handler"
  type        = string
}

variable "function_memory" {
  description = "Lambda Function ram memory"
  type        = number
  default     = 128
}

variable "function_timeout" {
  description = "Lambda Function timeout"
  type        = number
  default     = 10
}

variable "function_concurrency" {
  description = "Lambda Function Reserved concurrency execution"
  type        = number
  default     = -1
}

variable "function_vars" {
  description = "Lambda Function Environment Variables"
  type        = map(any)
  default     = null
}

variable "additional_policies" {
  description = "Arns of the additional policies for lambda"
  type        = list(string)
  default     = []
}

variable "runtime" {
  description = "Lambda runtime"
  default     = "python3.7"
}

#If both subnet_ids and security_group_ids are empty then vpc_config is considered to be empty or unset.
variable "subnet_ids" {
  description = "Subnet_id for lambda"
  default     = []
  type = list(string)
}
variable "security_group_ids" {
  description = "security_group_ids for lambda"
  default     = [] 
  type = list(string)
}