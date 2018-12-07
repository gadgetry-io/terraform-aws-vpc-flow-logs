# VPC Flow Logs
Creates a VPC flow to CloudWatch logs and schedules a daily partitioned dump to S3

## NOTE
This module requires `curl` be available on the machine running terraform so that it can download the lambda zip.

## Example

    module "vpc-flow-logs" {
      source        = "gadgetry-io/vpc-flow-logs/aws"
      version       = "0.0.1"
      vpc_id        = "vpc-xxxxxxx"
      database_name = "prd"
    }
