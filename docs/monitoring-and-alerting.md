# Monitoring and Alerting

Monitoring has no use if there are no notifications.

Set up a way to notify, e.g. a telegram bot. Which uses an API key. We can do this with discord instead.

He then adds the secrets to the key vault, via the CLI.

There was an additional terraform changes made:

- Monitoring kustomizations
  - controllers
  - configs

Using the kube-prometheus stack.

Introduces a kustomizeconfig.yaml which creates a generates a values file, so instead of putting it in the helm release, it is separate.

We disable prometheus alert manager and choose to use grafana instead.

For metrics he went to cnpg monitoring docs and found grafana alert rules.

The grafana alert rules he deployed via yaml files which are all configmaps.

He had to do a k rollout deployments again to pick up the configmaps.

Test alerting, scale down n8n cnpg operator deployments.

Grafana is better just have this internally. Not exposing it to an ingress.
