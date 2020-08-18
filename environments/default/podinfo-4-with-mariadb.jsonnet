local ws = import "jsonnet-libs/web-service/web-service.libsonnet";
ws {
  _config+:: {
    ws_cluster_hostname: "podinfo4.minikube.local",
    ws_name: "podinfo-4",
    ws_has_ingress: 'true',
    ws_readiness_probe: '/readyz',
    ws_port: 9898,

    resource_requests_cpu: '100m',
    resource_requests_ram: '64Mi',
    resource_limits_cpu: '300m',
    resource_limits_ram: '256Mi',
    
    replicas: 1,

    enable_mariadb: true,

  },
  _images+:: {
    ws: "stefanprodan/podinfo:latest",
  },
}

