targetScope = 'resourceGroup'

@description('The ACR name.')
param name string

@description('The Azure region.')
param location string

@description('The SKU for the registry.')
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param sku string = 'Standard'

@description('Whether admin user is enabled.')
param adminUserEnabled bool = false

@description('Resource tags.')
param tags object = {}

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: adminUserEnabled
  }
}

output id string = acr.id
output loginServer string = acr.properties.loginServer
