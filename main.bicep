targetScope = 'subscription'
param location string
param aksResourcePrefix string 
param clusterName string
param osDiskSizeGB int
param agentCount int
param agentVMSize string
param vnetSnetID string
param appGatewaySnetPrefix string

module appCluster './aks/aks-deployment.bicep' = {
  name: 'aksDeploy'
  params:{
    location: location
    clusterName: '${clusterName}-cluster'
    osDiskSizeGB: osDiskSizeGB
    agentCount:agentCount  
    agentVMSize : agentVMSize
    vnetSnetID:vnetSnetID
    appGatewaySnetPrefix:appGatewaySnetPrefix
    aksResourcePrefix:aksResourcePrefix
  }
}
