//local ws = import "mysite.libsonnet";
local ws = import 'jsonnet-libs/web-service/web-service.libsonnet';

ws {
  config+:: {

    namespace:: 'team-a',
    name:: 'podinfo-demo',

    cluster_env:: 'dev',
    cluster_region:: 'eu',
    cluster_domain:: 'minikube.local',
    cluster_name:: '',
    cluster_hostname:: 'podinfo.minikube.local',


    has_ingress:: 'true',

    image:: 'stefanprodan/podinfo:latest',

    resource_requests_cpu:: '100m',
    resource_requests_ram:: '64Mi',
    resource_limits_cpu:: '300m',
    resource_limits_ram:: '256Mi',

    common_annotations:: {},

    common_labels:: {
      'app.kubernetes.io/component': 'frontend',
      'app.kubernetes.io/name': 'podinfo',
      'app.kubernetes.io/part-of': 'podinfo',
      'app.mintel.com/owner': 'team-a',
      name: 'podinfo-demo',
    },


    env:: {
      var1: 'somevalue',
      var2: 'somevalue',
    },

    env_configmap_ref:: 'my-ws-env',
    // todo (create example configmap for this ref

    // replicas and auto-scaling
    replicas:: 2,
    enable_hpa:: true,

    enable_redis:: true,
    enable_mariadb:: true,
    enable_cloudsql_proxy:: true,
  },
}
