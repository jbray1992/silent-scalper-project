resource "aws_dynamodb_table" "file_metadata" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"

  # Attributes
  attribute {
    name = "file_id" # Changed from "id" to match index
    type = "S"
  }

  # Indexes
  hash_key = "file_id"
}
