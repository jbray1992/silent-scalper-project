variable "lambda_name" {
  description = "Lambda function name"
  type        = string
}

variable "alert_email" {
  description = "Email for error notifications"
  type        = string
}

variable "region" {
  description = "AWS region for monitoring resources"
  type        = string
}
