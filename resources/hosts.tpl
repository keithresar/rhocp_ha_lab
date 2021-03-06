[OSEv3:vars]

###########################################################################
### Ansible Vars
###########################################################################
timeout=60
ansible_become=yes

# disable memory check, as we are not a production environment
openshift_disable_check="memory_availability,disk_availability"

# Set this line to enable NFS
openshift_enable_unsupported_configurations=True

# Base config
openshift_deployment_type=openshift-enterprise
containerized=false
openshift_master_cluster_method=native
openshift_master_cluster_hostname=loadbalancer1.example.com
openshift_master_cluster_public_hostname=loadbalancer1-GUID.oslab.opentlc.com
#openshift_master_default_subdomain=apps.GUID.example.opentlc.com
openshift_master_default_subdomain=*.apps.GUID.example.opentlc.com
openshift_router_selector='env=infra'
openshift_hosted_infra_selector='env=infra'
openshift_hosted_registry_storage_nfs_directory=/srv/nfs
os_sdn_network_plugin_name=redhat/openshift-ovs-networkpolicy

# Auth
#openshift_master_ldap_ca_file=/root/ipa-ca.crt
#openshift_master_identity_providers=[{'name': 'ipa_shared_auth', 'login': 'true', 'challenge': 'true', 'kind': 'LDAPPasswordIdentityProvider', 'mappingMethod': 'claim', 'ca': '/etc/origin/master/ipa-ca.crt', 'bindDN': 'uid=admin,cn=users,cn=accounts,dc=shared,dc=example,dc=opentlc,dc=com', 'bindPassword': 'r3dh4t1!', 'url': 'ldaps://idm.example.com:636/cn=users,cn=accounts,dc=shared,dc=example,dc=opentlc,dc=com?uid?sub?(memberOf=cn=ocp-users,cn=groups,cn=accounts,dc=shared,dc=example,dc=opentlc,dc=com)', 'attributes': {'id': ['dn'], 'email': ['mail'], 'name': ['cn'], 'preferredUsername': ['uid']},}]


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

[lb]
loadbalancer1.example.com

[masters]
master1.example.com
master2.example.com
master3.example.com

[etcd]
master1.example.com
master2.example.com
master3.example.com

[nodes]
## These are the masters
master1.example.com openshift_hostname=master1.example.com openshift_node_labels="{'env': 'master', 'cluster': 'GUID'}"
master2.example.com openshift_hostname=master2.example.com openshift_node_labels="{'env': 'master', 'cluster': 'GUID'}"
master3.example.com openshift_hostname=master3.example.com openshift_node_labels="{'env': 'master', 'cluster': 'GUID'}"

## These are infranodes
infranode1.example.com openshift_hostname=infranode1.example.com openshift_node_labels="{'env':'infra', 'cluster': 'GUID'}"
infranode2.example.com openshift_hostname=infranode2.example.com openshift_node_labels="{'env':'infra', 'cluster': 'GUID'}"
infranode3.example.com openshift_hostname=infranode3.example.com openshift_node_labels="{'env':'infra', 'cluster': 'GUID'}"

## These are regular nodes
node1.example.com openshift_hostname=node1.example.com openshift_node_labels="{'env':'app', 'cluster': 'GUID'}"
node2.example.com openshift_hostname=node2.example.com openshift_node_labels="{'env':'app', 'cluster': 'GUID'}"
node3.example.com openshift_hostname=node3.example.com openshift_node_labels="{'env':'app', 'cluster': 'GUID'}"
node4.example.com openshift_hostname=node4.example.com openshift_node_labels="{'env':'app', 'cluster': 'GUID'}"
node5.example.com openshift_hostname=node5.example.com openshift_node_labels="{'env':'app', 'cluster': 'GUID'}"
node6.example.com openshift_hostname=node6.example.com openshift_node_labels="{'env':'app', 'cluster': 'GUID'}"

[nfs]
oselab.example.com openshift_hostname=oselab.example.com

