# Cilium on AKS

## Azure CNI powered by Cilium

- Azure CNI handles pod networking; Cilium provides the eBPF-based dataplane.
- _TODO_: Explain overlay and VNet networking modes and how they relate to pod addressing.
- _TODO_: Describe AKS-managed components, upgrades and support boundaries.

## Deployment considerations

- Review supported configurations and limitations for the target AKS version and region.
- Consider pod and service address ranges, cluster sizing and network policy requirements.
- The demo infrastructure configures Azure CNI overlay with the Cilium dataplane.

## Advanced Container Networking Services (ACNS)

- Introduce the optional managed networking features relevant to the presentation, including observability.
- _TODO_: Explain prerequisites, support and costs, and distinguish ACNS from the base Cilium dataplane.

> Speaker notes: _TODO_
