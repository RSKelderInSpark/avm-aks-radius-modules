targetScope = 'resourceGroup'

@description('The name of the deployment resource group.')
param resourceGroupName string = 'rg-aks-radius-demo'

@description('The Azure region for the example.')
param location string = 'eastus'

@description('Suffix used for generated resource names.')
param nameSuffix string = 'demo'

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

module network '../../modules/network/virtual-network/main.bicep' = {
  name: 'network'
  scope: rg
  params: {
    name: 'aks-vnet'
    location: location
    addressSpace: [
      '10.10.0.0/16'
    ]
    subnets: {
      aks: {
        addressPrefix: '10.10.1.0/24'
      }
    }
  }
}

module logAnalytics '../../modules/monitoring/log-analytics/main.bicep' = {
  name: 'logAnalytics'
  scope: rg
  params: {
    name: 'law-${nameSuffix}'
    location: location
  }
}

module acr '../../modules/container-registry/acr/main.bicep' = {
  name: 'acr'
  scope: rg
  params: {
    name: 'acr${nameSuffix}'
    location: location
  }
}

module aks '../../modules/aks/cluster/main.bicep' = {
  name: 'aks'
  scope: rg
  params: {
    name: 'aks-${nameSuffix}'
    location: location
    resourceGroupName: resourceGroupName
    dnsPrefix: 'aks-${nameSuffix}'
    subnetId: network.outputs.vnetId
  }
  dependsOn: [
    network
  ]
}

module radiusEnvironment '../../modules/radius/environment/main.bicep' = {
  name: 'radiusEnvironment'
  scope: rg
  params: {
    name: 'demo-env'
    location: location
    displayName: 'Demo Radius Environment'
  }
}

module radiusApplication '../../modules/radius/application/main.bicep' = {
  name: 'radiusApplication'
  scope: rg
  params: {
    name: 'demo-app'
    environmentId: radiusEnvironment.outputs.id
    displayName: 'Demo Radius Application'
  }
}

output aksClusterName string = aks.outputs.clusterName
output radiusEnvironmentId string = radiusEnvironment.outputs.id
output acrLoginServer string = acr.outputs.loginServer
