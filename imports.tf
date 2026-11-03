# Adopts what already existed in DependencyTrack when this repo was created (the teams
# DependencyTrack seeds on first start). Every one of these must show as an import and
# nothing else: any "to add" or "to change" here means a value in teams.tf was
# transcribed wrong. Once applied, these blocks can be deleted.
#
# Deliberately not imported: the 'tofu' team (tofu's own credentials; managing it could
# lock tofu out), the personal 'admin' user, team API keys (the provider can't import
# them), and built-ins DependencyTrack seeds itself (licenses, notification publishers,
# package repositories, default config properties).

import {
  to = dependencytrack_team.administrators
  id = "81758575-5551-4ca5-86a4-88acaa86dea9"
}

import {
  to = dependencytrack_team_permissions.administrators
  id = "81758575-5551-4ca5-86a4-88acaa86dea9"
}

import {
  to = dependencytrack_team.automation
  id = "0b687749-db97-4ed5-9424-d1375a574098"
}

import {
  to = dependencytrack_team_permissions.automation
  id = "0b687749-db97-4ed5-9424-d1375a574098"
}

import {
  to = dependencytrack_team.portfolio_managers
  id = "5676eea3-578c-4eaf-b93c-67842e90b6f4"
}

import {
  to = dependencytrack_team_permissions.portfolio_managers
  id = "5676eea3-578c-4eaf-b93c-67842e90b6f4"
}
