#!/bin/bash

# check correct KUBECONFIG context is available

kubectl config get-contexts openvox || exit 1


NAMESPACE="arc-system"
CONTROLLER_RELEASENAME="arc"
RUNNERSET_RELEASENAME="runnerset-themeier"

helm upgrade --install "$CONTROLLER_RELEASENAME" \
    --namespace "$NAMESPACE" \
    --create-namespace \
    --version 0.13.1 \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

helm upgrade --install "$RUNNERSET_RELEASENAME" \
    --namespace "$NAMESPACE" \
    --create-namespace \
    --version 0.13.1 \
    -f values-default-runner-set.yaml \
    -f secret-values.yaml \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set
