# GitOps and Customer Onboarding

## Dependency Order

- change of dependencies
  - infra-controllers (traefik, cert-manager, CNPG operator) -> infra-configs (ClusterIssuers) -> cnpg-plugin (barman cloud plugin) -> apps

## Customer Onboarding

We already have a staging directory.

- customers.tf file was created.
  - Terraform is used to generate manifests.
  - Local File Deployment.

## Production and Staging

- production cluster is pretty much the same with a few exceptions:
  - different name to signify production.
  - you could pass the cluster name
  - you could refactor this to be a module.
- All of the work happens on the 2 clusters. Production and Staging, these are two separate clusters.

## IaC Simplicity

- For infrastructure that doesn't change prefer simple, no modules.
- Do not over engineer IaC. It's not a software project.
