# Projects: what DependencyTrack tracks. Each holds the components of one SBOM and the
# findings against them.
#
# Only the project itself is managed here. SBOMs are data, not config: upload them in the
# UI (project → Components → Upload BOM) or with POST /api/v1/bom and an Automation key.

# linkding as homelab-cluster runs it (apps/base/linkding/deployment.yaml). Bump the
# version together with the image tag there, then upload the new image's SBOM.
resource "dependencytrack_project" "linkding" {
  name        = "linkding"
  version     = "1.47.0"
  classifier  = "CONTAINER"
  description = "Bookmark manager, sissbruecker/linkding container image (homelab-cluster)"
  purl        = "pkg:docker/sissbruecker/linkding@1.47.0"
}
