# Cilium overview

## Kubernetes networking challenges

- Workloads and their IP addresses change as applications scale and move.
- Teams need connectivity, isolation and visibility across services.

## What is Cilium?

- An open-source networking, security and observability platform for cloud-native workloads.
- eBPF runs programs in the Linux kernel; Cilium uses it to implement networking and security functions.
- _TODO_: Explain the datapath and identity model at a level appropriate for the audience.

## What are network policies?

- Kubernetes NetworkPolicy resources describe allowed ingress and egress traffic for selected pods.
- Isolation is directional: a pod becomes isolated for a direction when selected by a policy covering that direction; policies in that direction are additive.
- A network plugin that enforces policies is required.

## Why Cilium?

- Identity-aware networking and policy enforcement using workload labels.
- Visibility into network flows through Hubble.
- _TODO_: Discuss Cilium capabilities and trade-offs, distinguishing upstream features from those supported on AKS.

> Speaker notes: _TODO_
