targetScope = 'resourceGroup'

@description('The AKS cluster resource ID.')
param clusterId string

@description('The Kubernetes version to use for user node pools. Optional override.')
param orchestratorVersion string = ''

@description('A map of node pools keyed by name.')
param nodePools object = {}

@description('Tags to apply to node pools.')
param tags object = {}

resource nodePool 'Microsoft.ContainerService/managedClusters/agentPools@2024-09-01' = [for pool in items(nodePools): {
  name: pool.key
  parent: resourceId('Microsoft.ContainerService/managedClusters', split(clusterId, '/')[8])
  properties: {
    count: pool.value.nodeCount
    vmSize: pool.value.vmSize
    osDiskSizeGB: pool.value.osDiskSizeGB
    mode: contains(pool.value, 'mode') ? pool.value.mode : 'User'
    osType: contains(pool.value, 'osType') ? pool.value.osType : 'Linux'
    nodeLabels: contains(pool.value, 'nodeLabels') ? pool.value.nodeLabels : {}
    orchestratorVersion: empty(orchestratorVersion) ? null : orchestratorVersion
  }
  tags: tags
}]

output nodePoolIds array = [for pool in nodePool: pool.id]
