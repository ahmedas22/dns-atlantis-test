# Test DNS Zone - test-domain.com
# This is a mock zone for testing Atlantis workflows

terraform {
  required_version = ">= 1.9.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

variable "zone_id" {
  description = "Zone ID (mock for testing)"
  type        = string
  default     = "mock-zone-id-12345"
}

variable "domain" {
  description = "Domain name"
  type        = string
  default     = "test-domain.com"
}

locals {
  # A Records - MODIFY THESE TO TEST ATLANTIS
  a_records = {
    "@" = {
      value   = "192.168.1.1"
      proxied = false
      comment = "Root domain - test server"
    }
    "www" = {
      value   = "192.168.1.1"
      proxied = true
      comment = "WWW subdomain"
    }
    "api" = {
      value   = "192.168.1.10"
      proxied = true
      comment = "API server"
    }
    "staging" = {
      value   = "192.168.1.20"
      proxied = false
      comment = "Staging server - added via Atlantis"
    }
  }

  # CNAME Records
  cname_records = {
    "mail" = {
      value   = "mail.google.com"
      comment = "Email redirect"
    }
  }
}

resource "null_resource" "a_records" {
  for_each = local.a_records

  triggers = {
    name    = each.key
    value   = each.value.value
    proxied = each.value.proxied
    comment = each.value.comment
  }
}

resource "null_resource" "cname_records" {
  for_each = local.cname_records

  triggers = {
    name    = each.key
    value   = each.value.value
    comment = each.value.comment
  }
}

output "zone_summary" {
  value = {
    domain        = var.domain
    a_records     = keys(local.a_records)
    cname_records = keys(local.cname_records)
  }
}

output "total_records" {
  value = length(local.a_records) + length(local.cname_records)
}
