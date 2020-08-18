local ws = import "jsonnet-libs/web-service/web-service.libsonnet";
ws {
  _config+:: {
    namespace: "default",

    env: 'dev',
    region: 'eu',
    cluster_domain: 'minikube.local',

    ws_cluster_hostname: "podinfo.minikube.local",
    ws_name: "podinfo-demo",
    ws_has_ingress: 'true',

    resource_requests_cpu: '100m',
    resource_requests_ram: '64Mi',
    resource_limits_cpu: '300m',
    resource_limits_ram: '256Mi',
    
    name: 'my-test-app',
    replicas: 2,

  },
  _images+:: {
    ws: "stefanprodan/podinfo:latest",
  },
}

