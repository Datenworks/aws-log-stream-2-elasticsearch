output "arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = aws_lambda_function.default.arn
}

output "role_name" {
  description = "The name of IAM Role created for your Lambda Function."
  value       = aws_iam_role.default.name
}