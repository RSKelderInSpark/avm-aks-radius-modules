# AVM AKS + Radius Modules (Bicep)

This repository contains a full Azure Verified Modules (AVM)-style Bicep module catalog for Azure Kubernetes Service (AKS) and Radius.

The module structure keeps core platform concerns separated and reusable:
- network and identity foundation
- AKS cluster and nodepool composition
- logging, registry, and supporting services
- Radius environment and application modeling
- examples for end-to-end deployment

## Repository layout

- `modules/aks/cluster` — AKS cluster module
- `modules/aks/nodepool` — AKS node pools
- `modules/network/virtual-network` — VNet and subnets
- `modules/monitoring/log-analytics` — Log Analytics workspace
- `modules/container-registry/acr` — Azure Container Registry
- `modules/identity/user-assigned-identity` — managed identity
- `modules/radius/environment` — Radius environment
- `modules/radius/application` — Radius application
- `examples/aks-radius-basic` — sample deployment

## Deploy example

```bash
az group create --name rg-aks-radius-demo --location eastus
az deployment group create \
  --resource-group rg-aks-radius-demo \
  --template-file examples/aks-radius-basic/main.bicep
```

## Design goals

- AVM-leaning module boundaries
- resource group scoped modules
- consistent outputs and parameterization
- Azure-native deployment patterns
- Radius integration ready for environment and app composition

## Notes

This repo was initially scaffolded as Terraform and is now represented as a Bicep-first module set for Azure-native deployments.
