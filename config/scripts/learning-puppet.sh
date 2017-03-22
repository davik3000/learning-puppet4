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
  echo " > hardlock domain name"
  echo 'supercede domain-name "example.com";' > /etc/dhcp/dhclient.conf
}
function applyHosts()
{
  # Install etc/hosts for convenience
  echo " > apply configured hosts as /etc/hosts"
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
  echo "learning-puppet provision"
  hardlockDomain
  #applyHosts

  source ${CONFIG_DIR}/learning-puppet_install.sh ${CONFIG_DIR}
  source ${CONFIG_DIR}/learning-puppet_config.sh ${CONFIG_DIR}
fi;

echo "-----"