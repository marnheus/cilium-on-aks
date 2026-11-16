# Cilium on AKS

Support material for a presentation on **Cilium on Azure Kubernetes Service**: slides/notes in Markdown, demo scripts, and the Bicep IaC + GitHub Actions pipelines to deploy and tear down the demo cluster.

## Repository layout

```
docs/presentation/   Presentation content (Markdown, one file per section)
demos/               Demo scenarios (manifests + step-by-step scripts)
infra/               Bicep IaC for the AKS cluster (Azure CNI powered by Cilium)
.github/workflows/   Deploy, tear down and validate pipelines
```

## Demo cluster

`infra/main.bicep` (subscription scope) creates:

- Resource group `rg-cilium-aks-<environment>`
- AKS cluster `aks-cilium-<environment>` with:
  - Azure CNI overlay, **Cilium dataplane** and **Cilium network policy**
  - Optional Advanced Container Networking Services (Hubble observability, L7/FQDN policies)

## Pipelines

| Workflow | Trigger | Purpose |
|---|---|---|
| `deploy.yml` | Manual (`workflow_dispatch`) | What-if + deploy the cluster into the chosen environment |
| `teardown.yml` | Manual (`workflow_dispatch`) | Deletes the environment's resource group (requires typed confirmation) |
| `validate.yml` | PR / push | Builds and lints the Bicep |

### Setting up an environment

1. Create an Entra ID app registration (or user-assigned managed identity) with a **federated credential** for
   `repo:marnheus/cilium-on-aks:environment:<environment-name>`.
2. Grant it `Contributor` on the target subscription.
3. In GitHub → *Settings → Environments*, create `<environment-name>` and add the variables:
   - `AZURE_CLIENT_ID`
   - `AZURE_TENANT_ID`
   - `AZURE_SUBSCRIPTION_ID`
4. Run **Deploy demo cluster** and pick that environment.

### Local deployment

```bash
export ENVIRONMENT_NAME=demo AZURE_LOCATION=westeurope
az deployment sub create -l $AZURE_LOCATION -n cilium-aks-$ENVIRONMENT_NAME --parameters infra/main.bicepparam
az aks get-credentials -g rg-cilium-aks-$ENVIRONMENT_NAME -n aks-cilium-$ENVIRONMENT_NAME
```
