output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.file_metadata.arn
}
