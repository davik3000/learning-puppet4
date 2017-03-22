#!/bin/bash
echo "-----"
echo "puppet installation"

AMIROOT=$(whoami)
SUDOCMD=""
if [ "${AMIROOT}" != "root" ] ; then
  SUDOCMD="sudo -E"
fi

# DART probably not needed
echo " > importing RPM GPG key from puppetlabs servers"
${SUDOCMD} rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
${SUDOCMD} rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppet

echo " > update/install repository from puppetlabs servers"
${SUDOCMD} rpm -Uh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

echo " > install puppet"
${SUDOCMD} yum -q -y install puppet
echo "-----"