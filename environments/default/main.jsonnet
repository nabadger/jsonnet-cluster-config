(import "podinfo-1.jsonnet") +
(import "podinfo-2.jsonnet") +
{
  _config+:: {
    env: 'dev',
    region: 'eu',
    cluster_domain: 'minikube.local',
  },
}

