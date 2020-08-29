{
  config+:: {
    replicas:: 5,
    enable_hpa:: false,
    resource_limits_cpu::'2000m',
    resource_limits_ram::'4Gi',
  },
}
