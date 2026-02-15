#!/bin/bash

# check correct KUBECONFIG context is available

kubectl config get-contexts openvox || exit 1


NAMESPACE="arc-system"
CONTROLLER_RELEASENAME="arc"


helm uninstall  runnerset-voxpupuli \
    --namespace "$NAMESPACE" \
    --wait

helm uninstall runnerset-openvoxproject \
    --namespace "$NAMESPACE" \
    --wait


helm uninstall "$CONTROLLER_RELEASENAME" \
    --namespace "$NAMESPACE" \
    --wait
