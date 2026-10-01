targetScope = 'resourceGroup'

@description('Name of the Radius application.')
param name string

@description('The Radius environment resource ID.')
param environmentId string

@description('Friendly display name for the application.')
param displayName string = ''

@description('Application type.')
param applicationType string = 'Containerized'

@description('Tags to apply to the resource.')
param tags object = {}

resource radiusEnvironment 'Microsoft.Radius/environments@2024-04-01-preview' existing = {
  name: last(split(environmentId, '/'))
}

resource radiusApplication 'Microsoft.Radius/applications@2024-04-01-preview' = {
  name: name
  parent: radiusEnvironment
  tags: tags
  properties: {
    applicationType: applicationType
    displayName: empty(displayName) ? name : displayName
    environmentId: environmentId
  }
}

output id string = radiusApplication.id
output name string = radiusApplication.name
