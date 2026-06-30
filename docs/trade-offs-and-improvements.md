# Trade-Offs and Improvements

## Current Trade-Offs

- For infrastructure that doesn't change prefer simple, no modules.
- Do not over engineer IaC. It's not a software project.

## Questions

- in production I believe each customer would have it's own grafana instance.
- does each customer have their own dbs? Pretty sure yes.
- KRO yaml and crossplane or python. But you can do it with terraform.

## Improvement Ideas

- We need to take the code and improve it in our own way.
- Ideas
  - Add more environments
  - Write a python CLI using typer to generate manifests / onboard clients instead of terraform.
  - Migrate to Gateway API (the new ingress)
    - There is an Azure version
    - Cilium
    - Traefik
  - Automatically update the Object ID in the monitoring manifests
  - Promoting releases through PR workflows
  - Renovate for version upgrades
  - pgAdmin
  - add cnpg grafana dashboard as json and pod monitors (on the docs)
