#!/bin/bash

#################################
# Global settings
SHARED_PUPPET_DIR=
#################################

#############
# Functions #
#############
function addPuppetlabsToSudoSecurePath()
{
  # Add /opt/puppetlabs to the sudo secure_path
  sed -i -e 's#\(secure_path = .*\)$#\1:/opt/puppetlabs/bin#' /etc/sudoers
}
function configurePuppet()
{
  echo "-----"
  echo "Configuring puppet"

  echo " > link 'hiera.yaml' from shared folder"
  ln -sf ${SHARED_PUPPET_DIR}/hiera.yaml /etc/puppetlabs/code/hiera.yaml

  echo " > remove 'modules' folder from guest /etc/puppetlabs"
  rm -rf /etc/puppetlabs/code/modules

  echo " > link 'modules' folder from shared folder"
  ln -sf ${SHARED_PUPPET_DIR}/environments/development/modules /etc/puppetlabs/code/modules
}
function installPuppetConf()
{
  # Install puppet.conf in user directory to share code directory
  mkdir -p /home/vagrant/.puppetlabs/etc/puppet
  cp /vagrant/etc-puppet/personal-puppet.conf /home/vagrant/.puppetlabs/etc/puppet/puppet.conf
  chown -R vagrant:vagrant /home/vagrant/.puppetlabs
}
function installHieraConf()
{
  # Install example hiera settings in global directory
  mkdir -p /etc/puppetlabs/puppet
  cp /vagrant/etc-puppet/puppet.conf /etc/puppetlabs/puppet/
  mkdir -p /etc/puppetlabs/code
  chown -R vagrant:vagrant /etc/puppetlabs
}

########
# Main #
########

# use argument for config folder path
if [ -n $1 ] ; then
  SHARED_PUPPET_DIR=$1
fi;

addPuppetlabsToSudoSecurePath
configurePuppet

echo "-----"
