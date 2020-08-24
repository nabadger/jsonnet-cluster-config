local ws = import 'jsonnet-libs/web-service/web-service.libsonnet';

ws + { 
  
  namespace:: "default",

  env:: 'dev',
  cluster_region:: 'eu',
  cluster_domain:: 'minikube.local',
  cluster_name:: '',

  ws_cluster_hostname:: "podinfo.minikube.local",
  ws_name:: "podinfo_v2",
  ws_has_ingress:: 'true',
  ws_image:: 'stefanprodan/podinfo:v2.0.0',
  resource_requests_cpu:: '100m',
  resource_requests_ram:: '64Mi',
  resource_limits_cpu:: '300m',
  resource_limits_ram:: '256Mi',

  ws_env:: {
    var2: 'somevalue',
  },

  ws_env_configmap_ref:: 'my-ws-env',
  // todo (create example configmap for this ref

  replicas:: 4444,

  enable_redis:: true,
  enable_mariadb:: true,
  enable_cloudsql_proxy:: true,
}
