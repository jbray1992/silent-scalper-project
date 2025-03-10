output "input_bucket_name" {
  description = "Name of the input S3 bucket"
  value       = var.input_bucket_name
}

output "quarantine_bucket_name" {
  description = "Name of the quarantine S3 bucket"
  value       = var.quarantine_bucket_name
}

output "input_bucket_arn" {
  description = "ARN of the input S3 bucket"
  value       = aws_s3_bucket.input_bucket.arn
}
