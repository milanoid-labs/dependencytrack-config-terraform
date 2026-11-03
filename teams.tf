# The teams DependencyTrack seeds on first start, and their permissions (adopted with
# import blocks in #2). DependencyTrack 5 splits most areas into the umbrella permission plus
# _CREATE/_READ/_UPDATE/_DELETE; the full list is GET /api/v1/permission.
#
# Not managed here:
# - The 'tofu' team: OpenTofu's own credentials (all permissions, one API key), made by
#   hand. Managing it from here could let a bad plan lock tofu out.
# - Team members (the personal 'admin' user is in Administrators) and API keys.

resource "dependencytrack_team" "administrators" {
  name = "Administrators"
}

# Every permission DependencyTrack 5.2 has (42).
resource "dependencytrack_team_permissions" "administrators" {
  team = dependencytrack_team.administrators.id
  permissions = [
    "ACCESS_MANAGEMENT",
    "ACCESS_MANAGEMENT_CREATE",
    "ACCESS_MANAGEMENT_DELETE",
    "ACCESS_MANAGEMENT_READ",
    "ACCESS_MANAGEMENT_UPDATE",
    "BOM_UPLOAD",
    "POLICY_MANAGEMENT",
    "POLICY_MANAGEMENT_CREATE",
    "POLICY_MANAGEMENT_DELETE",
    "POLICY_MANAGEMENT_READ",
    "POLICY_MANAGEMENT_UPDATE",
    "POLICY_VIOLATION_ANALYSIS",
    "PORTFOLIO_ACCESS_CONTROL_BYPASS",
    "PORTFOLIO_MANAGEMENT",
    "PORTFOLIO_MANAGEMENT_CREATE",
    "PORTFOLIO_MANAGEMENT_DELETE",
    "PORTFOLIO_MANAGEMENT_READ",
    "PORTFOLIO_MANAGEMENT_UPDATE",
    "PROJECT_CREATION_UPLOAD",
    "SECRET_MANAGEMENT",
    "SECRET_MANAGEMENT_CREATE",
    "SECRET_MANAGEMENT_DELETE",
    "SECRET_MANAGEMENT_UPDATE",
    "SYSTEM_CONFIGURATION",
    "SYSTEM_CONFIGURATION_CREATE",
    "SYSTEM_CONFIGURATION_DELETE",
    "SYSTEM_CONFIGURATION_READ",
    "SYSTEM_CONFIGURATION_UPDATE",
    "TAG_MANAGEMENT",
    "TAG_MANAGEMENT_DELETE",
    "VIEW_POLICY_VIOLATION",
    "VIEW_PORTFOLIO",
    "VIEW_VULNERABILITY",
    "VULNERABILITY_ANALYSIS",
    "VULNERABILITY_ANALYSIS_CREATE",
    "VULNERABILITY_ANALYSIS_READ",
    "VULNERABILITY_ANALYSIS_UPDATE",
    "VULNERABILITY_MANAGEMENT",
    "VULNERABILITY_MANAGEMENT_CREATE",
    "VULNERABILITY_MANAGEMENT_DELETE",
    "VULNERABILITY_MANAGEMENT_READ",
    "VULNERABILITY_MANAGEMENT_UPDATE",
  ]
}

# For CI pipelines that upload SBOMs (give it an API key to use from a pipeline).
resource "dependencytrack_team" "automation" {
  name = "Automation"
}

resource "dependencytrack_team_permissions" "automation" {
  team = dependencytrack_team.automation.id
  permissions = [
    "BOM_UPLOAD",
    "VIEW_PORTFOLIO",
  ]
}

resource "dependencytrack_team" "portfolio_managers" {
  name = "Portfolio Managers"
}

resource "dependencytrack_team_permissions" "portfolio_managers" {
  team = dependencytrack_team.portfolio_managers.id
  permissions = [
    "PORTFOLIO_MANAGEMENT",
    "PORTFOLIO_MANAGEMENT_CREATE",
    "PORTFOLIO_MANAGEMENT_DELETE",
    "PORTFOLIO_MANAGEMENT_READ",
    "PORTFOLIO_MANAGEMENT_UPDATE",
    "VIEW_PORTFOLIO",
  ]
}
