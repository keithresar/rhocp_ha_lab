#!/bin/bash

echo -n "Enter GUID: > "
read guid

cp resources/hosts.tpl /tmp/hosts.tmp
perl -p -i -e "s/GUID/$guid/g" /tmp/hosts.tmp

#echo "Getting IDM Cert" && \
#curl -O /root/ipa-ca.crt http://ipa.example.com/ipa/config/ca.crt  && \
#echo "----------------" && \
#\
echo "Installing pre-reqs" && \
yum -y install atomic-openshift-utils atomic-openshift-clients atomic-openshift openshift-ansible-playbooks
echo "----------------" && \
\
echo "Running OCP config" && \
time ansible-playbook -f 20 -i /tmp/hosts.tmp /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml && \
echo "----------------" && \
#\
#echo "Deploying cluster" && \
#time ansible-playbook -f 20 -i /tmp/hosts.tmp /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml && \
#echo "----------------" && \

rm -f /tmp/hosts.tmp

