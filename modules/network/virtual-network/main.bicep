targetScope = 'resourceGroup'

@description('The virtual network name.')
param name string

@description('The Azure region.')
param location string

@description('The address space for the VNet.')
param addressSpace array

@description('A map of subnet definitions keyed by subnet name.')
param subnets object = {}

@description('Resource tags.')
param tags object = {}

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressSpace
    }
    subnets: [for subnet in items(subnets): {
      name: subnet.key
      properties: {
        addressPrefix: subnet.value.addressPrefix
      }
    }]
  }
}

output vnetId string = vnet.id
output subnetIds object = {
  'aks': vnet.properties.subnets[0].id
}
