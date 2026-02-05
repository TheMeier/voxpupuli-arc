# OpenVox GitHub Actions Runner (ARC)

Self-hosted GitHub Actions runner deployment using [Actions Runner Controller (ARC)](https://github.com/actions/actions-runner-controller) on Kubernetes.

## Overview

This project deploys a GitHub Actions Runner Scale Set for running on the `openvox` Kubernetes cluster. It uses Helm to install:

1. **ARC Controller** (`gha-runner-scale-set-controller`)
2. **Runner Scale Set** (`gha-runner-scale-set`)

Both components are deployed to the `arc-system` namespace at chart version `0.13.1`.

## Prerequisites

- `kubectl` configured with the `openvox` context
- `helm`  > 3.x installed
- A GitHub App configured for the target organization with

## Files

| File                             | Description                                                        |
| -------------------------------- | ------------------------------------------------------------------ |
| `install-arc-controller.sh`      | Installs/upgrades the ARC controller and runner scale set via Helm |
| `values-default-runner-set.yaml` | Runner pod template (image, resources, volumes)                    |

### Missing file
`secret-values.yaml` — contains sensitive values (GitHub App credentials) and is not included in version control

### Images

Images can be found at:
- ARC Controller: [ghcr.io/actions/actions-runner-controller](https://github.com/actions/runner/pkgs/container/gha-runner-scale-set-controller)
- Runner Scale Set: [ghcr.io/actions/actions-runner-controller](https://github.com/actions/runner/pkgs/container/actions-runner)

For the controller the helm-chart version is used as tag by default (limited config options in helm-chart). For the runner set the version is set in the template spec of the runner set.

## GitHub App

The GitHub App must be setup as described in the [ARC documentation](https://docs.github.com/en/actions/tutorials/use-actions-runner-controller/authenticate-to-the-api#authenticating-arc-with-a-github-app)

The GitHub App must be installed on the target organization.

The resulting runner group on the organization must be configured to be used on public repositories, otherwise the runners will not pick up jobs from public repos. (https://github.com/organizations/$ORG/settings/actions/runners)

## Using in VoxPupli GitHub Actions

To use the self-hosted runners in voxpupuli standard actions the followig things are needed:

modify the exisiting puppet job in `.github/workflows/ci.yml` (*Managed by modulesync!*) to pass `unit_runs_on: 'NAME_OF_RUNNER_SET'` and `additional_packages: 'build-essential ruby-dev`

In case [basic](https://github.com/TheMeier/gha-puppet/blob/v4/.github/workflows/basic.yml) is used instead of [beaker](https://github.com/TheMeier/gha-puppet/blob/v4/.github/workflows/beaker.yml) there is still an open [issue](https://github.com/voxpupuli/gha-puppet/pull/90)
