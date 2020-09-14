resource "aws_glue_catalog_table" "this" {
  name          = var.table_name
  database_name = var.database_name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    classification="csv"
    "skip.header.line.count"="1" 
    "typeOfData"="file"  
  }

  storage_descriptor {
    location      = var.location
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name = "my-store-serde"  
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"
      parameters = {
        "serialization.format" = 1
        "separatorChar"= var.separators 
      }
    } 
    dynamic "columns" {
      for_each = var.columns
      content {
        name   = columns.key
        type   = columns.value
      }
    }
  }

  dynamic "partition_keys" {
    for_each = var.partition_keys
    content {
        name   = partition_keys.key
        type   = partition_keys.value
    }
  }
}


