module "cloudwatch-logs-exporter" {
  source           = "gadgetry-io/cloudwatch-logs-exporter/aws"
  name             = "${terraform.workspace}-vpc-flow-log-exporter"
  version          = "0.0.5"
  exporter_version = "0.0.2"
  log_group        = "/${terraform.workspace}/vpc-flow-logs"
  s3_bucket        = "${aws_s3_bucket.main.id}"
  s3_prefix        = "exports"
  schedule         = "cron(15 5 * * ? *)"
}
