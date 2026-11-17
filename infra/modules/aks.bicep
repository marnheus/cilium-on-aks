@description('Name of the AKS cluster.')
param clusterName string

param location string = resourceGroup().location

@description('Kubernetes version. Leave empty to use the AKS default.')
param kubernetesVersion string = ''

param nodeVmSize string = 'Standard_D4s_v5'

@minValue(1)
param nodeCount int = 2

@description('Enable Advanced Container Networking Services (Hubble observability, L7 policies, and FQDN filtering).')
param enableAdvancedNetworking bool = true

param tags object = {}

resource aks 'Microsoft.ContainerService/managedClusters@2025-08-01' = {
  name: clusterName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: clusterName
    kubernetesVersion: empty(kubernetesVersion) ? null : kubernetesVersion
    agentPoolProfiles: [
      {
        name: 'system'
        mode: 'System'
        vmSize: nodeVmSize
        count: nodeCount
        osType: 'Linux'
        osSKU: 'AzureLinux'
      }
    ]
    // Azure CNI Powered by Cilium (overlay mode)
    networkProfile: {
      networkPlugin: 'azure'
      networkPluginMode: 'overlay'
      networkDataplane: 'cilium'
      networkPolicy: 'cilium'
      podCidr: '192.168.0.0/16'
      advancedNetworking: enableAdvancedNetworking
        ? {
            enabled: true
            observability: {
              enabled: true
            }
            security: {
              enabled: true
              advancedNetworkPolicies: 'L7'
            }
          }
        : null
    }
  }
}

output clusterName string = aks.name
output clusterId string = aks.id
