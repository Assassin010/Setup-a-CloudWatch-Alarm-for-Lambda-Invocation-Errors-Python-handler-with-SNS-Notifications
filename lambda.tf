resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  depends_on = [
  aws_iam_role_policy_attachment.test-attach
]
  filename      = "${data.archive_file.my_lambda_function.output_path}"
  function_name = "lambda_function"
  role          = aws_iam_role.iam_role_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  timeout       = 6

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = "${data.archive_file.my_lambda_function.output_base64sha256}"
  runtime = "python3.8"

  environment {
       variables = {
           REGION = "${var.aws_region}"
       }
   }
}

data "archive_file" "my_lambda_function" {
  type        = "zip"
  output_path = "my_lambda_function.zip"
  source_file = "lambda_function.py"

}

#Next lets create a policy that lambda will use to create the ec2 instances
resource "aws_iam_policy" "mypolicy" {
  name        = "mypolicy"
  description = "sns permission for lambda "
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


resource "aws_iam_role" "iam_role_for_lambda" {
  name               = "iam_role_for_lambda"
  assume_role_policy = jsonencode({
   Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }

}




resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_role_for_lambda.name
  count      = length(var.iam_policy_arn)
  policy_arn = var.iam_policy_arn[count.index]
  depends_on = [
    aws_iam_policy.mypolicy
  ]
}

