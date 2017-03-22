#!/bin/bash

# Functions
exec_vagrant_halt() {
  echo "-----"
  echo "Halt running machines"
  vagrant halt $@
  return $?
}
disable_vagrant_plugins() {
  export VAGRANT_NO_PLUGINS=1
}
enable_vagrant_plugins() {
  unset VAGRANT_NO_PLUGINS
}
exec_vagrant_woPlugins() {
  echo "-----"
  echo "Create the nodes"

  echo " > disabling Vagrant plugins"
  disable_vagrant_plugins

  echo " > create and boot VMs"
  vagrant up $@
  return $?
}
exec_vagrant_provision() {
  echo "-----"
  echo "Applying provision to nodes"
  vagrant provision $@
  return $?
}
exec_vagrant_wPlugin() {
  echo "-----"
  echo "Reboot the nodes (and apply guest addition through plugin)"

  echo " > enabling Vagrant plugins"
  enable_vagrant_plugins

  echo " > reboot the VMs"
  vagrant reload $@
  return $?
}

# Main
exec_vagrant_halt $@

if [ $? -eq 0 ] ; then
  exec_vagrant_woPlugins $@
fi

#if [ $? -eq 0 ] ; then
#  exec_vagrant_provision
#fi

if [ $? -eq 0 ] ; then
  exec_vagrant_wPlugin $@
fi

echo "-----"
echo "Ready to go"
