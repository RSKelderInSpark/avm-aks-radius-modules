targetScope = 'resourceGroup'

@description('The identity name.')
param name string

@description('The Azure region.')
param location string

@description('Resource tags.')
param tags object = {}

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: name
  location: location
  tags: tags
}

output id string = identity.id
output clientId string = identity.properties.clientId
output principalId string = identity.properties.principalId
