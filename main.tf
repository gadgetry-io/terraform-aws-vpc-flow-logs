resource "aws_flow_log" "main" {
  log_destination = "${aws_cloudwatch_log_group.main.arn}"
  iam_role_arn    = "${aws_iam_role.main.arn}"
  vpc_id          = "${var.vpc_id}"
  traffic_type    = "ALL"
}

# Log group to store network traffic
resource "aws_cloudwatch_log_group" "main" {
  name              = "/${terraform.workspace}/vpc-flow-logs"
  retention_in_days = 3
}

# IAM role to store network logs
resource "aws_iam_role" "main" {
  name = "${terraform.workspace}-vpc-flow-logs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# IAM policy authorizing the IAM role
resource "aws_iam_role_policy" "main" {
  name = "${terraform.workspace}-vpc-flow-logs"
  role = "${aws_iam_role.main.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "${aws_cloudwatch_log_group.main.arn}"
    }
  ]
}
EOF
}
