#!/bin/bash

echo -n "Enter GUID: > "
read guid

cp resources/hosts.tpl /tmp/hosts.tmp
perl -p -i -e "s/GUID/$guid/g" /tmp/hosts.tmp

echo "Installing pre-reqs" && \
yum -y install atomic-openshift-utils atomic-openshift-clients atomic-openshift openshift-ansible-playbooks
echo "----------------" && \
time ansible-playbook -f 20 -i hosts.tmp /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml && \
echo "----------------" && \
time ansible-playbook -f 20 -i hosts.tmp /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml

rm -f /tmp/hosts.tmp

