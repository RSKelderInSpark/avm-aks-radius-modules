targetScope = 'resourceGroup'

@description('The name of the AKS cluster.')
param name string

@description('The Azure region for the AKS cluster.')
param location string

@description('The name of the resource group containing the AKS cluster.')
param resourceGroupName string

@description('The DNS prefix for the AKS cluster.')
param dnsPrefix string

@description('The Kubernetes version to deploy.')
param kubernetesVersion string = '1.30'

@description('The name of the system node pool.')
param defaultNodePoolName string = 'system'

@description('The number of initial nodes in the system pool.')
param defaultNodeCount int = 2

@description('The VM size for the default node pool.')
param defaultVmSize string = 'Standard_DS2_v2'

@description('The OS disk size in GB.')
param osDiskSizeGB int = 128

@description('The subnet resource ID used by the AKS node pool.')
param subnetId string

@description('The AKS network plugin to use.')
@allowed([
  'azure'
  'kubenet'
])
param networkPlugin string = 'azure'

@description('The load balancer SKU used by AKS.')
@allowed([
  'basic'
  'standard'
])
param loadBalancerSku string = 'standard'

@description('Additional tags to apply to the cluster.')
param tags object = {}

resource aks 'Microsoft.ContainerService/managedClusters@2024-09-01' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: dnsPrefix
    kubernetesVersion: kubernetesVersion
    agentPoolProfiles: [
      {
        name: defaultNodePoolName
        count: defaultNodeCount
        vmSize: defaultVmSize
        osDiskSizeGB: osDiskSizeGB
        osType: 'Linux'
        mode: 'System'
        type: 'VirtualMachineScaleSets'
        vnetSubnetID: subnetId
      }
    ]
    networkProfile: {
      networkPlugin: networkPlugin
      loadBalancerSku: loadBalancerSku
    }
  }
}

output clusterId string = aks.id
output clusterName string = aks.name
output principalId string = aks.identity.principalId
