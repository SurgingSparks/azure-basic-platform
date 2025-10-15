@description('Azure region for the deployment')
param location string = resourceGroup().location

@description('Name of the virtual network resource.')
param virtualNetworkName string = 'demo-vnet'

@description('Array of address blocks reserved for this virtual network, in CIDR notation.')
param addressSpace object = {
  addressPrefixes: [
    '10.1.0.0/16'
  ]
}

@description('Array of subnets for this virtual network.')
param subnets array = [
  {
    name: 'public'
    properties: {
      addressPrefixes: [
        '10.1.1.0/24'
      ]
    }
  }
  {
    name: 'private'
    properties: {
      addressPrefixes: [
        '10.1.2.0/24'
      ]
    }
  }
]

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: addressSpace
    subnets: subnets
  }
}

output vnetId string = virtualNetwork.id
output subnetIds array = [for s in subnets: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name, s.name)]
