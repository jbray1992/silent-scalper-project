variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the Lambda function"
  type        = string
}

variable "region" {
  description = "AWS region for API Gateway"
  type        = string
}
