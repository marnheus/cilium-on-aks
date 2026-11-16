using 'main.bicep'

param environmentName = readEnvironmentVariable('ENVIRONMENT_NAME', 'demo')
param location = readEnvironmentVariable('AZURE_LOCATION', 'westeurope')
param nodeCount = 2
param enableAdvancedNetworking = true
