terraform {
  required_providers {
    splunk = {
      source = "splunk/splunk"
    }
  }
}

variable "everything_splunk" {
  type = string
}

provider "splunk" {
  url                  = "${var.everything_splunk}:8089"
  username             = "admin"
  password             = "cr1bluser"
  insecure_skip_verify = true
}


resource "splunk_indexes" "student-events" {
  name     = "student1_logs"
  datatype = "event"
}


resource "splunk_indexes" "student-metrics" {
  name     = "student1_metrics"
  datatype = "metric"
}

