# Projects: what DependencyTrack tracks. Each holds the components of one SBOM and the
# findings against them.
#
# Only the project itself is managed here. SBOMs are data, not config: upload them in the
# UI (project → Components → Upload BOM) or with POST /api/v1/bom and an Automation key.
#
# Projects whose images our own CI builds (devops-study-app) are different: CI uploads the
# SBOM and creates a project per release (autoCreate=true, parentName=...). Only the
# stable parent is managed here, so a release needs no tofu PR.

# linkding as homelab-cluster runs it (apps/base/linkding/deployment.yaml). Bump the
# version together with the image tag there, then upload the new image's SBOM.
resource "dependencytrack_project" "linkding" {
  name        = "linkding"
  version     = "1.47.0"
  classifier  = "CONTAINER"
  description = "Bookmark manager, sissbruecker/linkding container image (homelab-cluster)"
  # purl is left out on purpose: each SBOM upload sets it from the BOM's metadata (the
  # image digest), so managing it here would only fight the upload.
}

# Parent of the per-release projects (study-app-api <version>, study-app-web <version>)
# that devops-study-app's CI creates on each release. Version-less on purpose.
resource "dependencytrack_project" "devops_study_app" {
  name        = "devops-study-app"
  classifier  = "APPLICATION"
  description = "devops-study-app (milanoid-labs/devops-study-app); per-release projects are created by its CI"
}
