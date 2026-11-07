# DependencyTrack config properties (Administration → Configuration). Import IDs are
# group/property; the full list is GET /api/v1/configProperty. Only settings changed from
# DependencyTrack's defaults, or decided on purpose, are managed here.

# Used to build links back to DependencyTrack in notifications and badges. Unset, those
# links have no host. LAN-only, plain HTTP (see homelab-cluster
# apps/base/dependencytrack/release.yaml).
import {
  to = dependencytrack_config_property.base_url
  id = "general/base.url"
}

resource "dependencytrack_config_property" "base_url" {
  group_name = "general"
  name       = "base.url"
  value      = var.dependencytrack_url
}

# Telemetry is on by default. It sends a random system ID, the DependencyTrack version and
# the database type and version, about once a day; no project or vulnerability data.
# Turned off so nothing leaves the homelab unasked.
import {
  to = dependencytrack_config_property.telemetry_submission_enabled
  id = "telemetry/submission.enabled"
}

resource "dependencytrack_config_property" "telemetry_submission_enabled" {
  group_name = "telemetry"
  name       = "submission.enabled"
  value      = "false"
}
