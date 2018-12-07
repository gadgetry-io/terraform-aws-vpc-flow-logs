variable "database_name" {
  description = "The Glue/Athena database name for vpc-flow-log table"
  default     = "default"
}

variable "table_name" {
  description = "The Glue/Athena table name for vpc-flow-log"
  default     = "vpc_flow_logs"
}

variable "vpc_id" {
  description = "The target VPC"
}
