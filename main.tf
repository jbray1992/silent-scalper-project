module "lambda" {
  source                 = "./modules/lambda"
  function_name          = "file-processor"
  lambda_package         = "modules/lambda_src/processor.zip"
  region                 = var.region
  input_bucket_arn       = module.s3.input_bucket_arn
  input_bucket_name      = module.s3.input_bucket_name
  quarantine_bucket_name = module.s3.quarantine_bucket_name
  dynamodb_table_arn     = module.dynamodb.table_arn
}

module "s3" {
  source                 = "./modules/s3"
  region                 = var.region
  input_bucket_name      = "silent-scalper-input"
  quarantine_bucket_name = "silent-scalper-quarantine"
  lambda_function_arn    = module.lambda.lambda_arn
}

module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = "file-metadata-table"
}

module "api_gateway" {
  source     = "./modules/api_gateway"
  api_name   = "silent-scalper-api"
  region     = var.region
  lambda_arn = module.lambda.lambda_arn
}

module "monitoring" {
  source      = "./modules/monitoring"
  lambda_name = module.lambda.function_name
  region      = var.region
  alert_email = "alerts@yourdomain.com" # Replace with your actual email
}
