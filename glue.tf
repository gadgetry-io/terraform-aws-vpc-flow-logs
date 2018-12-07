resource "aws_glue_catalog_table" "main" {
  name          = "${var.table_name}"
  database_name = "${var.database_name}"
  table_type    = "EXTERNAL_TABLE"

  partition_keys = [
    {
      name = "year"
      type = "string"
    },
    {
      name = "month"
      type = "string"
    },
    {
      name = "day"
      type = "string"
    },
  ]

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.main.id}/exports"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info = {
      name                  = "RegexSerDe"
      serialization_library = "org.apache.hadoop.hive.serde2.RegexSerDe"

      parameters = {
        "input.regex" = "^([^ ]+)\\s+([0-9]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([0-9]+)\\s+([0-9]+)\\s+([0-9]+)\\s+([0-9]+)\\s+([0-9]+)\\s+([0-9]+)\\s+([0-9]+)\\s+([^ ]+)\\s+([^ ]+)$"
      }
    }

    columns = [
      {
        name = "ts"
        type = "string"
      },
      {
        name = "version"
        type = "int"
      },
      {
        name = "account"
        type = "string"
      },
      {
        name = "interfaceid"
        type = "string"
      },
      {
        name = "sourceaddress"
        type = "string"
      },
      {
        name = "destinationaddress"
        type = "string"
      },
      {
        name = "sourceport"
        type = "int"
      },
      {
        name = "destinationport"
        type = "int"
      },
      {
        name = "protocol"
        type = "int"
      },
      {
        name = "numpackets"
        type = "int"
      },
      {
        name = "numbytes"
        type = "int"
      },
      {
        name = "starttime"
        type = "int"
      },
      {
        name = "endtime"
        type = "int"
      },
      {
        name = "action"
        type = "string"
      },
      {
        name = "logstatus"
        type = "string"
      },
    ]
  }
}
