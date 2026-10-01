# AKS Node Pool Module

Adds additional AKS node pools to a cluster.

## Example

```bicep
module userPools 'modules/aks/nodepool/main.bicep' = {
  name: 'aks-nodepools'
  scope: resourceGroup()
  params: {
    clusterId: aks.outputs.clusterId
    nodePools: {
      user: {
        vmSize: 'Standard_DS3_v2'
        nodeCount: 2
        osDiskSizeGB: 128
        mode: 'User'
      }
    }
  }
}
```
