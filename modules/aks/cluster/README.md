# AKS Cluster Module

This module creates the core AKS managed cluster used by the environment.

## Example

```bicep
module aks 'modules/aks/cluster/main.bicep' = {
  name: 'aks'
  scope: resourceGroup()
  params: {
    name: 'aks-demo'
    location: location
    resourceGroupName: resourceGroup().name
    dnsPrefix: 'aks-demo'
    subnetId: network.outputs.subnetIds['aks']
  }
}
```
