variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "lambda_package" {
  description = "Path to the Lambda deployment package"
  type        = string
  default     = "modules/lambda_src/processor.zip"
}

variable "input_bucket_name" {
  description = "Name of the S3 input bucket"
  type        = string
}

variable "quarantine_bucket_name" {
  description = "Name of the S3 quarantine bucket"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  type        = string
}

variable "region" {
  description = "AWS region for resources"
  type        = string
}

variable "input_bucket_arn" {
  description = "ARN of the input S3 bucket"
  type        = string
}
