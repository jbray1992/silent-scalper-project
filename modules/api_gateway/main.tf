data "aws_caller_identity" "current" {}

resource "aws_api_gateway_rest_api" "gateway" {
  name = var.api_name
}

resource "aws_api_gateway_resource" "lambda_proxy" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  parent_id   = aws_api_gateway_rest_api.gateway.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.gateway.id
  resource_id   = aws_api_gateway_resource.lambda_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.gateway.id
  resource_id             = aws_api_gateway_resource.lambda_proxy.id
  http_method             = aws_api_gateway_method.proxy_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations"
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.gateway.id}/*/*/*"
}
