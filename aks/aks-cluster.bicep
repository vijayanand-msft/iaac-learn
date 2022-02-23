param location string
param clusterName string


@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string 

@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int

@description('The number of nodes for the cluster.')
@minValue(1)
@maxValue(50)
param agentCount int

@description('The size of the Virtual Machine.')
param agentVMSize string

@description('The vNET subnet name to create the cluster.')
param vnetSnetID string

@description('The Subnet range where Appgateway is deployed.')
param appGatewaySnetPrefix string

resource aks 'Microsoft.ContainerService/managedClusters@2021-10-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  tags: {
    Environment: 'Sandbox'
    displayName: 'aks101cluster'
  }
  
  properties: {
    kubernetesVersion: '1.21.9'
    dnsPrefix: dnsPrefix
    enableRBAC: true
    networkProfile: {
      networkPlugin: 'azure'
    }
   
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
        type: 'VirtualMachineScaleSets'
        vnetSubnetID: vnetSnetID
      }
      
    ]
    addonProfiles: {
      httpApplicationRouting: {
        enabled: false
      }
      ingressApplicationGateway: {
        enabled: true
        config: {
          applicationGatewayName: 'ingress-appgateway'
          subnetprefix: appGatewaySnetPrefix
        }
      }
    }
}
}
output controlPlaneFQDN string = aks.properties.fqdn
