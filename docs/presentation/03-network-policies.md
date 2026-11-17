# Network segregation and policies with Cilium

## Segregating workloads

- Use namespaces and workload labels to define trust boundaries and policy targets.
- Start with an explicit isolation strategy, then allow the application flows that are required.
- _TODO_: Contrast Kubernetes NetworkPolicy with Cilium policy capabilities supported on AKS.

## Ingress policies

- Select the destination pods and define which sources, ports and protocols may reach them.
- _TODO_: Walk through an example allowing only a frontend workload to reach a backend.

## Egress policies

- Select the source pods and define which destinations, ports and protocols they may reach.
- Account for required dependencies such as DNS and external services.
- _TODO_: Walk through an example restricting backend egress.

## Policy evaluation and demo

- Policies are additive within a direction; where both ends are isolated, source egress and destination ingress must both allow the connection.
- Plan how to verify allowed and denied flows before enforcing isolation.
- [Network policies demo outline](../../demos/01-network-policies/README.md) (steps and manifests to be developed).

> Speaker notes: _TODO_
