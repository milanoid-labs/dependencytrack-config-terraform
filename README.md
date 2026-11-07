# DependencyTrack configuration (OpenTofu)

OpenTofu configuration for the homelab [DependencyTrack](https://dependencytrack.org/)
5.2 (`http://dependencytrack.milanoid.net`): teams and their permissions, projects, and later
policies and settings.

DependencyTrack itself (the Helm chart, its Postgres role and database, the ingress)
is deployed by Flux from
[homelab-cluster](https://github.com/milanoid-labs/homelab-cluster) (`apps/base/dependencytrack/`).
This repo only manages what lives *inside* DependencyTrack. Anything not declared here
is left alone.

## Layout

| File | Manages |
|---|---|
| `teams.tf` | The teams DependencyTrack seeds on first start (`Administrators`, `Automation`, `Portfolio Managers`) and their permissions |
| `projects.tf` | Projects (`linkding`). Only the project; SBOM uploads are data and stay out of tofu |
| `terraform.tf` | Backend, provider, the DependencyTrack connection variables |

Deliberately unmanaged:
- the `tofu` team (see [Credentials](#credentials));
- the personal `admin` user and team members;
- team API keys, which DependencyTrack only shows on creation and the provider can't import;
- the built-ins DependencyTrack seeds itself: licenses, notification publishers, package
  repositories and default config properties.

Provider: [`ottramst/dependencytrack`](https://github.com/ottramst/terraform-provider-dependencytrack),
tested upstream against DependencyTrack 5.2. It probes `GET /api/version` at configure
time and adapts to the server's major version. `SolarFactories/dependencytrack` is only
tested on 4.x.

State lives in S3 (`milanoid-labs-terraform-tofu-state`, key
`dependencytrack-config-terraform/terraform.tfstate`). CI's AWS roles for it are managed
centrally in `milanoid-labs-terraform/bootstrap/aws-oidc/tofu_repos.tf`.

## Credentials

OpenTofu authenticates with the API key of the DependencyTrack team `tofu`, which has all
permissions and no members. It was created by hand once, because tofu can't create
the credentials it logs in with. It isn't managed here, so a bad plan can't lock tofu out.

- CI: repo secret `TF_VAR_DEPENDENCYTRACK_API_KEY`, mapped to `TF_VAR_dependencytrack_api_key`
  in the workflows.
- Locally: [direnv](https://direnv.net/). `.envrc` (committed, no secrets) loads
  `~/.config/dependencytrack-config-terraform.env` (mode 600):
  ```sh
  export TF_VAR_dependencytrack_api_key=...   # lowercase, matches the variable name
  export AWS_PROFILE=milanoid
  ```
  Run `direnv allow` once after cloning.

To rotate the key, generate a new one on the `tofu` team in the UI, update the repo secret
and the env file, then revoke the old key.

## Workflow

PR → `Tofu Plan` posts the plan as a PR comment → merge → `Tofu Apply` on `main`.
`main` is protected by a ruleset (PR required), managed in `milanoid-labs-terraform`.

CI runs on `homelab-runners`, because DependencyTrack is only reachable on the LAN. It's
plain HTTP (Traefik only has its default certificate on 443), so the API key crosses
the LAN unencrypted.

## Local use

```sh
direnv allow
tofu init
tofu plan
```

Applies normally happen through CI. To adopt something that already exists in
DependencyTrack, add an `import` block and let OpenTofu draft the resource:
`tofu plan -generate-config-out=generated.tf`. Then move the cleaned-up resource into
the right file. The plan must show only imports.
