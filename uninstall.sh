#!/bin/bash

# check correct KUBECONFIG context is available

kubectl config get-contexts openvox || exit 1


NAMESPACE="arc-system"

helm uninstall  runnerset-voxpupuli \
    --namespace "$NAMESPACE" \
    --wait

helm uninstall runnerset-openvoxproject \
    --namespace "$NAMESPACE" \
    --wait

