#!/bin/bash

# check correct KUBECONFIG context is available

kubectl config get-contexts openvox || exit 1


NAMESPACE="arc-system"
CONTROLLER_RELEASENAME="arc"


helm upgrade --install "$CONTROLLER_RELEASENAME" \
    --namespace "$NAMESPACE" \
    --create-namespace \
    --version 0.13.1 \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

helm upgrade --install runnerset-voxpupuli \
    --namespace "$NAMESPACE" \
    --version 0.13.1 \
    -f values-default-runner-set.yaml \
    -f secret-values.yaml \
    --set controllerServiceAccount.name="arc-gha-rs-controller" \
    --set controllerServiceAccount.namespace="$NAMESPACE" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set


helm upgrade --install runnerset-openvoxproject \
    --namespace "$NAMESPACE" \
    --create-namespace \
    --version 0.13.1 \
    -f values-default-runner-set.yaml \
    -f secret-values.yaml \
    --set controllerServiceAccount.name="arc-gha-rs-controller" \
    --set controllerServiceAccount.namespace="$NAMESPACE" \
    --set githubConfigSecret.github_app_installation_id="110304284" \
    --set githubConfigUrl="https://github.com/openvoxproject" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set
