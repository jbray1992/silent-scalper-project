variable "input_bucket_name" {
  description = "Name of the input S3 bucket"
  type        = string
}

variable "quarantine_bucket_name" {
  description = "Name of the quarantine S3 bucket"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to trigger"
  type        = string
}

variable "region" {
  description = "AWS region where resources are deployed"
  type        = string
}
