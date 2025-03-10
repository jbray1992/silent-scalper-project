module "s3" {
  source                 = "../s3"
  region                 = var.region
  input_bucket_name      = var.input_bucket_name
  quarantine_bucket_name = var.quarantine_bucket_name
  lambda_function_arn    = aws_lambda_function.processor.arn
}

resource "aws_lambda_function" "processor" {
  function_name = var.function_name
  filename      = var.lambda_package
  role          = aws_iam_role.lambda_exec.arn
  handler       = "processor.lambda_handler"
  runtime       = "python3.9"

  environment {
    variables = {
      INPUT_BUCKET      = var.input_bucket_name
      QUARANTINE_BUCKET = var.quarantine_bucket_name
      DYNAMODB_TABLE    = var.dynamodb_table_arn
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.function_name}-policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::${var.input_bucket_name}/*",
          "arn:aws:s3:::${var.quarantine_bucket_name}/*"
        ]
      },
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem"
        ]
        Effect   = "Allow"
        Resource = "${var.dynamodb_table_arn}"
      }
    ]
  })
}

resource "aws_lambda_permission" "s3_trigger" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.processor.arn
  principal     = "s3.amazonaws.com"

  source_arn = var.input_bucket_arn
}
