local podinfo = import '../../../common/team-a/podinfo/podinfo.jsonnet';
local common = import 'common.libsonnet';
local podinfo_overrides = import 'overrides/team-a/podinfo.libsonnet';
{
  podinfo: podinfo + podinfo_overrides,
  //common
}
