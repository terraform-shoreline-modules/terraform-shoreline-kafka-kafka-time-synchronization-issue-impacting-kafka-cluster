terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "kafka_time_synchronization_issue_impacting_kafka_cluster" {
  source    = "./modules/kafka_time_synchronization_issue_impacting_kafka_cluster"

  providers = {
    shoreline = shoreline
  }
}