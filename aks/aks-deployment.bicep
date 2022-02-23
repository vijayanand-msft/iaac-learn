targetScope = 'subscription'

param location string
param aksResourcePrefix string 
param clusterName string
param osDiskSizeGB int
param agentCount int
param agentVMSize string
param vnetSnetID string
param appGatewaySnetPrefix string

var resourceGroupName = 'rg-${aksResourcePrefix}'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module aks './aks-cluster.bicep' = {
  name: '${clusterName}-cluster'
  scope: rg
  params: {
    location:location
    clusterName: '${clusterName}-cluster'
    dnsPrefix: '${clusterName}-cluster'
    osDiskSizeGB: osDiskSizeGB
    agentCount:agentCount  
    agentVMSize : agentVMSize
    vnetSnetID:vnetSnetID
    appGatewaySnetPrefix:appGatewaySnetPrefix
}
}
