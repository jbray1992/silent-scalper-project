resource "aws_s3_bucket" "input_bucket" {
  bucket = var.input_bucket_name
}

resource "aws_s3_bucket_versioning" "input_bucket_versioning" {
  bucket = aws_s3_bucket.input_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "input_bucket_encryption" {
  bucket = aws_s3_bucket.input_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "quarantine_bucket" {
  bucket = var.quarantine_bucket_name
}

resource "aws_s3_bucket_versioning" "quarantine_bucket_versioning" {
  bucket = aws_s3_bucket.quarantine_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "quarantine_bucket_encryption" {
  bucket = aws_s3_bucket.quarantine_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.input_bucket.id

  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
  }
}
