targetScope = 'resourceGroup'

@description('Name of the Radius environment.')
param name string

@description('Azure region for the environment.')
param location string

@description('Environment type. For example: Production or Dev.')
param environmentType string = 'Production'

@description('Friendly display name for the environment.')
param displayName string = ''

@description('Tags to apply to the resource.')
param tags object = {}

resource radiusEnvironment 'Microsoft.Radius/environments@2024-04-01-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
    environmentType: environmentType
    displayName: empty(displayName) ? name : displayName
  }
}

output id string = radiusEnvironment.id
output name string = radiusEnvironment.name
