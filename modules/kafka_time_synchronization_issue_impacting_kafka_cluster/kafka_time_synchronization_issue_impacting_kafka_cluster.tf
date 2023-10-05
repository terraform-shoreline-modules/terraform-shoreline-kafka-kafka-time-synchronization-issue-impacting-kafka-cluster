resource "shoreline_notebook" "kafka_time_synchronization_issue_impacting_kafka_cluster" {
  name       = "kafka_time_synchronization_issue_impacting_kafka_cluster"
  data       = file("${path.module}/data/kafka_time_synchronization_issue_impacting_kafka_cluster.json")
  depends_on = [shoreline_action.invoke_check_time_zone,shoreline_action.invoke_time_sync_script]
}

resource "shoreline_file" "check_time_zone" {
  name             = "check_time_zone"
  input_file       = "${path.module}/data/check_time_zone.sh"
  md5              = filemd5("${path.module}/data/check_time_zone.sh")
  description      = "The time zone settings on the affected servers may have been incorrect or changed."
  destination_path = "/agent/scripts/check_time_zone.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "time_sync_script" {
  name             = "time_sync_script"
  input_file       = "${path.module}/data/time_sync_script.sh"
  md5              = filemd5("${path.module}/data/time_sync_script.sh")
  description      = "Check the time synchronization settings on all servers hosting the Kafka cluster and ensure that they are set to the correct time zone and are synced with a reliable time source."
  destination_path = "/agent/scripts/time_sync_script.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_check_time_zone" {
  name        = "invoke_check_time_zone"
  description = "The time zone settings on the affected servers may have been incorrect or changed."
  command     = "`chmod +x /agent/scripts/check_time_zone.sh && /agent/scripts/check_time_zone.sh`"
  params      = ["SERVER1","SERVER2","SERVER3"]
  file_deps   = ["check_time_zone"]
  enabled     = true
  depends_on  = [shoreline_file.check_time_zone]
}

resource "shoreline_action" "invoke_time_sync_script" {
  name        = "invoke_time_sync_script"
  description = "Check the time synchronization settings on all servers hosting the Kafka cluster and ensure that they are set to the correct time zone and are synced with a reliable time source."
  command     = "`chmod +x /agent/scripts/time_sync_script.sh && /agent/scripts/time_sync_script.sh`"
  params      = ["TIME_SERVER","TIME_ZONE"]
  file_deps   = ["time_sync_script"]
  enabled     = true
  depends_on  = [shoreline_file.time_sync_script]
}

