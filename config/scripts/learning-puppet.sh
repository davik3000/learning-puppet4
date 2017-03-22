#!/bin/bash

#################################
# Global settings
CONFIG_DIR=
#################################

#############
# Functions #
#############
function hardlockDomain()
{
  # Hardlock domain name
  echo 'supercede domain-name "example.com";' > /etc/dhcp/dhclient.conf
}
function applyHosts()
{
  # Install etc/hosts for convenience
  cp /vagrant/etc-puppet/hosts /etc/hosts
}

########
# Main #
########

# use argument for config folder path
if [ -n $1 ] ; then
  CONFIG_DIR=$1
fi;

if [ -d ${CONFIG_DIR} ] ; then
  hardlockDomain
  #applyHosts

  source ${CONFIG_DIR}/puppet_install.sh ${CONFIG_DIR}
  source ${CONFIG_DIR}/puppet_configure.sh ${CONFIG_DIR}
fi;

echo "-----"