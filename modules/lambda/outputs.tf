output "lambda_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.processor.arn
}

output "function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.processor.function_name
}

output "function_invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  value       = aws_lambda_function.processor.invoke_arn
}
