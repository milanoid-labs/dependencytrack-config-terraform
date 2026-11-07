# Vulnerability data sources DependencyTrack mirrors (Administration → Vulnerability Sources).
#
# The internal analyzer matches components against the mirrored data. NVD (enabled by
# default) only matches by CPE, and SBOMs from Trivy carry purls, not CPEs, so NVD alone
# finds nothing in them. OSV matches by purl, including distro packages (pkg:deb).
#
# Each config replaces the whole extension config, so every field is listed.

import {
  to = dependencytrack_extension_config.osv
  id = "vuln-data-source/osv"
}

resource "dependencytrack_extension_config" "osv" {
  extension_point = "vuln-data-source"
  extension       = "osv"
  config = jsonencode({
    enabled                     = true
    dataUrl                     = "https://storage.googleapis.com/osv-vulnerabilities"
    incrementalMirroringEnabled = true
    aliasSyncEnabled            = true
    # The defaults plus Debian (the base of the linkding image). Names as in
    # https://ossf.github.io/osv-schema/#defined-ecosystems.
    ecosystems = ["Debian", "Go", "Maven", "npm", "NuGet", "PyPI"]
  })
}
