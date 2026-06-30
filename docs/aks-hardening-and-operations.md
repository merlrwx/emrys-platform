# AKS Hardening and Operations

## Authentication

Best practice is to use Entra ID.

Create a User, Create Groups (RBAC), Add in the object ID into the terraform into `azure_active_directory_role_based_access_control` which enables Entra ID.

Add Role Assignment for the Cluster and Subscription, e.g. Reader and Admin

The difference between Kubernetes Base Authentication, Kubernetes RBAC and Azure RBAC.

In Entra ID with Kubernetes RBAC, this is just authentication to the cluster. e.g. `k get clusterrolebindings.rbac.authorization.k8s.io | grep admin` shows the kubernetes RBAC to apply to the groups

`k describe clusterrolebindings.rbac.authorization.k8s.io aks-cluster-admin-binding-aad` shows the group IDs which have access

With Azure RBAC it has role assignments for namespaces in Azure. But you can just do this group the Kubernetes roles.

Kubernetes RBAC is cleaner and less fine grained.

## Node Pool Separation

There are two types of node pools, system and user. The idea is that we don't want user applications to crash system pools.

This can be done with taints. You can see this when we get pods, agentpool is system and userpool is user.

Some daemonsets run on both such as cilium.

To do this, specify in terraform:

- default node pool which the system agentpool
- set max surge to 33% - the % that is allowed to be drained and rescheduled at the same time.
- create a new node pool for the user pool.

We have now seperated system from user pools.

## Scheduled Maintenance and Node Upgrades

### Process Linux Node Updates

- When the Linux kernel needs to be patched, not Kubernetes.
- We need a maintenance window where we do these upgrades.

### Node Image Upgrades

- When Kubernetes has an upgrade.

To resolve both of these, we change the terraform file to include:
`maintenance_window_auto_upgrade` with one for the node OS and one for kubernetes. This updates the patch version which is the last digit in the version.

However we also need to update the major version in terraform this is the upgrade channel.

## Restricted Policy

- To enforce a policy just add a label in the namespace, we should always aim for restricted, as this is the best practice.

In order to get this to work we need to make changes:

Pod level:

- runAsNonRoot - prevents non root
- runAsUser/Group: 1000 - runs as node user
- fsGroup: 1000 - file ownership for volumes
- seccompProfile - kernel syscall filtering

Container level:

- allowPrivlegeEscalation: false - no priv esc
- readOnlyRootFilesystem: true - immutable container filesystem
- capabilities.drop - no linux capabilities

## Resource Management

Add resource management e.g. CPU, RAM limits'

## Health Probes

- Liveness Probe - verification that the application is running, process could be running but the application is unhealthy
- Readiness Probe - only mark a container as ready once condition is met

## Network Policy

- Cilium Network Policies
  - https://editor.networkpolicy.io
  - Select the app
  - Set ingress
    - allow traefik ingress controller
  - Set egress
    - allow database
    - DNS resoloution
    - allow https
