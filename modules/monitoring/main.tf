resource "aws_cloudwatch_log_group" "lambda_logs" {
  name = "/aws/lambda/${var.lambda_name}"
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "${var.lambda_name}-ErrorAlarm"
  alarm_description   = "Triggered when Lambda function errors exceed 1 within a 5-minute period"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  dimensions = {
    FunctionName = var.lambda_name
  }
}

resource "aws_sns_topic" "alerts" {
  name = "error-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
