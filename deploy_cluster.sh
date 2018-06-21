#!/bin/bash

echo -n "Enter GUID: > "
read guid

cp resources/hosts.tpl /tmp/hosts.tmp
perl -p -i -e "s/GUID/$guid/g" /tmp/hosts.tmp

echo "----------------" && \
time echo ansible-playbook -f 20 -i hosts.tmp /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml && \
echo "----------------" && \
time echo ansible-playbook -f 20 -i hosts.tmp /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml

rm -f /tmp/hosts.tmp

