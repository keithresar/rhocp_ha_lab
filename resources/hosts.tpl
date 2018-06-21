[OSEv3:vars]

###########################################################################
### Ansible Vars
###########################################################################
timeout=60
ansible_become=yes
ansible_ssh_user=ec2-user

# disable memory check, as we are not a production environment
openshift_disable_check="memory_availability"

# Set this line to enable NFS
openshift_enable_unsupported_configurations=True

# Base config
openshift_deployment_type=openshift-enterprise
containerized=false
openshift_master_cluster_method=native
openshift_master_cluster_hostname=loadbalancer1.GUID.internal
openshift_master_cluster_public_hostname=loadbalancer.GUID.example.opentlc.com
openshift_master_default_subdomain=apps.GUID.example.opentlc.com
openshift_router_selector='env=infra'
openshift_hosted_infra_selector='env=infra'
openshift_hosted_registry_storage_nfs_directory=/srv/nfs
os_sdn_network_plugin_name=ovs-networkpolicy

# Auth
openshift_master_ldap_ca_file=/root/ipa-ca.crt
openshift_master_identity_providers=[{'name': 'ipa_shared_auth', 'login': 'true', 'challenge': 'true', 'kind': 'LDAPPasswordIdentityProvider', 'mappingMethod': 'claim', 'ca': '/etc/origin/master/ipa-ca.crt', 'bindDN': 'uid=admin,cn=users,cn=accounts,dc=shared,dc=example,dc=opentlc,dc=com', 'bindPassword': 'r3dh4t1!', 'url': 'ldaps://ipa.shared.example.opentlc.com:636/cn=users,cn=accounts,dc=shared,dc=example,dc=opentlc,dc=com?uid?sub?(memberOf=cn=ocp-users,cn=groups,cn=accounts,dc=shared,dc=example,dc=opentlc,dc=com)', 'attributes': {'id': ['dn'], 'email': ['mail'], 'name': ['cn'], 'preferredUsername': ['uid']},}]
#openshift_master_identity_providers=[ 'attributes': {'id': ['dn'], 'email': ['mail'], 'name': ['cn'], 'preferredUsername': ['uid']}, 'insecure': 'false', 'url': 'ldap://ldap.myorg.com:389/uid=users,dc=myorg,dc=com?uid'}]


# Logging
openshift_logging_install_logging=true
openshift_logging_storage_kind=nfs
openshift_logging_storage_access_modes=['ReadWriteOnce']
openshift_logging_storage_nfs_directory=/srv/nfs
openshift_logging_storage_nfs_options='*(rw,root_squash)'
openshift_logging_storage_volume_name=logging
openshift_logging_storage_volume_size=10Gi

openshift_loggingops_storage_nfs_directory=/srv/nfs
#openshift_loggingops_storage_volume_name=

# Metrics
openshift_metrics_install_metrics=true
openshift_metrics_storage_kind=nfs
openshift_metrics_storage_access_modes=['ReadWriteOnce']
openshift_metrics_storage_nfs_directory=/srv/nfs
openshift_metrics_storage_nfs_options='*(rw,root_squash)'
openshift_metrics_storage_volume_name=metrics
openshift_metrics_storage_volume_size=10Gi

## Add Prometheus Metrics:
openshift_hosted_prometheus_deploy=true
openshift_prometheus_node_selector={"env":"infra"}
openshift_prometheus_namespace=openshift-metrics
openshift_prometheus_storage_nfs_directory=/srv/nfs
openshift_prometheus_alertmanager_storage_nfs_directory=/srv/nfs
openshift_prometheus_alertbuffer_storage_nfs_directory=/srv/nfs

# Service catalog
openshift_enable_service_catalog=true
openshift_hosted_etcd_storage_kind=nfs
openshift_hosted_etcd_storage_access_modes=["ReadWriteOnce"]
openshift_hosted_etcd_storage_nfs_directory=/srv/nfs 
openshift_hosted_etcd_storage_nfs_options="*(rw,root_squash,sync,no_wdelay)"
openshift_hosted_etcd_storage_volume_name=etcd-vol2 
openshift_hosted_etcd_storage_volume_size=1G
openshift_hosted_etcd_storage_labels={'storage': 'etcd'}


###########################################################################
### OpenShift Hosts
###########################################################################
[OSEv3:children]
lb
masters
etcd
nodes
nfs
#glusterfs

[lb]
loadbalancer1.GUID.internal

[masters]
#master1.GUID.internal
master2.GUID.internal
master3.GUID.internal

[etcd]
#master1.GUID.internal
master2.GUID.internal
master3.GUID.internal

[nodes]
## These are the masters
#master1.GUID.internal openshift_hostname=master1.GUID.internal  openshift_node_labels="{'env': 'master', 'cluster': 'GUID'}"
master2.GUID.internal openshift_hostname=master2.GUID.internal  openshift_node_labels="{'env': 'master', 'cluster': 'GUID'}"
master3.GUID.internal openshift_hostname=master3.GUID.internal  openshift_node_labels="{'env': 'master', 'cluster': 'GUID'}"

## These are infranodes
infranode1.GUID.internal openshift_hostname=infranode1.GUID.internal  openshift_node_labels="{'env':'infra', 'cluster': 'GUID'}"
infranode2.GUID.internal openshift_hostname=infranode2.GUID.internal  openshift_node_labels="{'env':'infra', 'cluster': 'GUID'}"

## These are regular nodes
node1.GUID.internal openshift_hostname=node1.GUID.internal  openshift_node_labels="{'env':'app', 'cluster': 'GUID'}"
node2.GUID.internal openshift_hostname=node2.GUID.internal  openshift_node_labels="{'env':'app', 'cluster': 'GUID'}"
node3.GUID.internal openshift_hostname=node3.GUID.internal  openshift_node_labels="{'env':'app', 'cluster': 'GUID'}"

## These are CNS nodes
# support1.GUID.internal openshift_hostname=support1.GUID.internal  openshift_node_labels="{'env':'glusterfs', 'cluster': 'GUID'}"
# support2.GUID.internal openshift_hostname=support2.GUID.internal  openshift_node_labels="{'env':'glusterfs', 'cluster': 'GUID'}"
# support3.GUID.internal openshift_hostname=support3.GUID.internal  openshift_node_labels="{'env':'glusterfs', 'cluster': 'GUID'}"

[nfs]
support1.GUID.internal openshift_hostname=support1.GUID.internal

#[glusterfs]
# support1.GUID.internal glusterfs_devices='[ "/dev/xvdd" ]'
# support2.GUID.internal glusterfs_devices='[ "/dev/xvdd" ]'
# support3.GUID.internal glusterfs_devices='[ "/dev/xvdd" ]'
