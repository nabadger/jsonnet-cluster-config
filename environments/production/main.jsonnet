local app = import "app/app.libsonnet";
app {
  _config+:: {
    namespace: "default",
    app_cluster_domain: "mintel.com",
    app_name: "podinfo-demo",
    replicas: 4,
  },
  _images+:: {
    app: "stefanprodan/podinfo:latest",
  },
}

