// this import is not wokring as expected yet - overwriting config, so only 
// ending up with last-import resources
(import "podinfo-1.jsonnet") +
(import "podinfo-2.jsonnet") +
(import "podinfo-3-with-redis.jsonnet") +
(import "podinfo-4-with-mariadb.jsonnet") +
{
  _config+:: {
    env: 'dev',
    region: 'eu',
    cluster_domain: 'minikube.local',
  },
}

