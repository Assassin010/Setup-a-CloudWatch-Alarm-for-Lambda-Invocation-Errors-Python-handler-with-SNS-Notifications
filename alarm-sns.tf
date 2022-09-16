resource "aws_sns_topic" "topic" {
  name = "topic-name"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = "foxrivers33@gmail.com"

  depends_on = [
    aws_sns_topic.topic
  ]
}

resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = "all-lambdas-errors"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = "60"
  statistic                = "Average"

  #FunctionName - (always add ".function_name" at the end)
  dimensions = {
    FunctionName = "${aws_lambda_function.test_lambda.function_name}"
  }
  threshold                 = "0"
  alarm_description         = "Lambdas with errors"

  #In Alarm state
  alarm_actions = [aws_sns_topic.topic.arn]

depends_on = [
  aws_lambda_function.test_lambda
]
}