resource "aws_s3_bucket" "main" {
  bucket = "${terraform.workspace}-vpc-flow-logs-${data.aws_caller_identity.current.account_id}"
  acl    = "private"

  tags {
    Name        = "${terraform.workspace}-vpc-flow-logs"
    Environment = "${terraform.workspace}"
  }

  policy = "${data.aws_iam_policy_document.s3_bucket.json}"
}

data "aws_iam_policy_document" "s3_bucket" {
  statement {
    sid = "AllowCloudWatchLogsGetBucketAcl"

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::${terraform.workspace}-vpc-flow-logs-${data.aws_caller_identity.current.account_id}",
    ]

    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
  }

  statement {
    sid = "AllowCloudWatchLogsPutObject"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${terraform.workspace}-vpc-flow-logs-${data.aws_caller_identity.current.account_id}/*",
    ]

    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
