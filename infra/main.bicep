targetScope = 'subscription'

@description('Short name of the target environment (e.g. demo, dev).')
param environmentName string

@description('Azure region for all resources.')
param location string = 'westeurope'

@description('Name of the resource group hosting the demo cluster.')
param resourceGroupName string = 'rg-cilium-aks-${environmentName}'

@description('Name of the AKS cluster.')
param clusterName string = 'aks-cilium-${environmentName}'

@description('Kubernetes version. Leave empty to use the AKS default.')
param kubernetesVersion string = ''

@description('VM size of the system node pool.')
param nodeVmSize string = 'Standard_D4s_v5'

@description('Number of nodes in the system node pool.')
@minValue(1)
param nodeCount int = 2

@description('Enable Advanced Container Networking Services (Hubble observability, L7 policies, and FQDN filtering).')
param enableAdvancedNetworking bool = true

param tags object = {
  project: 'cilium-on-aks'
  environment: environmentName
}

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

module aks 'modules/aks.bicep' = {
  name: 'aks-${environmentName}'
  scope: rg
  params: {
    clusterName: clusterName
    location: location
    kubernetesVersion: kubernetesVersion
    nodeVmSize: nodeVmSize
    nodeCount: nodeCount
    enableAdvancedNetworking: enableAdvancedNetworking
    tags: tags
  }
}

output resourceGroupName string = rg.name
output clusterName string = aks.outputs.clusterName
