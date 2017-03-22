#!/bin/bash

# Provide the URL to the Puppet Labs yum repo on login
echo "
You should start by enabling the Puppet Labs Puppet Collection 1 release repo
   sudo yum install http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

Then install Puppet 4 and its companion packages
   sudo yum install -y puppet-agent
   
" > /etc/motd

# Enable MotD, if disabled
sed -i -e 's/^PrintMotd no/PrintMotd yes/' /etc/ssh/sshd_config

# DART disabled, nice to have
# it's too complex for its simple purpose: load a banner on ssh login
#echo " > reloading sshd"
#systemctl -q reload sshd
#
#systemctl -q show sshd
#if [ $? -ne 0 ] ; then
#  echo " > cannot reload, restarting sshd"
#  systemctl -q restart sshd
#fi