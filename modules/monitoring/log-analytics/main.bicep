targetScope = 'resourceGroup'

@description('The Log Analytics workspace name.')
param name string

@description('The Azure region.')
param location string

@description('The retention period in days.')
param retentionInDays int = 30

@description('Tags to apply to the resource.')
param tags object = {}

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: retentionInDays
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
}

output workspaceId string = workspace.id
output customerId string = workspace.properties.customerId
output primarySharedKey string = workspace.listKeys().primarySharedKey
