# AKS + Radius Basic Example

This example deploys:
- resource group
- VNet and subnet
- AKS cluster
- Log Analytics workspace
- Azure Container Registry
- Radius environment and application

## Deploy

```bash
az deployment group create \
  --resource-group rg-aks-radius-demo \
  --template-file examples/aks-radius-basic/main.bicep
```
