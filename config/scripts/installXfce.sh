#!/bin/bash

#############
# Functions #
#############
install_xfce() {
  echo "Installing Xfce"
  echo "> yum: install epel-release"
  sudo yum install -y -q epel-release
  
  echo "> yum: install 'Server with GUI'"
  sudo yum groups install -y -q "Server with GUI"
  
  echo "> yum: install Xfce"
  sudo yum groups install -y -q "Xfce"
}

enable_sys_graphic() {
  NEW_TARGET='graphical.target'

  echo "> systemctl: checking default target..."
  CURR_TARGET=$(systemctl get-default | grep ${NEW_TARGET})

  if [ -z "${CURR_TARGET}" ] ; then
    echo " > enabling graphical.target. Note: reboot required!"
    systemctl set-default ${NEW_TARGET}
  else
    echo " > already set to graphical.target"
  fi;
}

#enable_xfce_session() {
#  echo "> enabling Xfce session"
#  
#  EXEC_XFCE_SESSION="exec /usr/bin/xfce4-session"
#  XINITRC_PATH=/root/.xinitrc
#  XFCE_EXIST=
#  
#  if [ -f ${XINITRC_PATH} ] ; then
#    echo " > detected xinitrc"
#    XFCE_EXIST=$(grep -ce '^exec.*xfce4-session$' ${XINITRC_PATH})
#  fi;
#  
#  if [ -eq ${XFCE_EXIST} 1 ] ; then
#    echo ${EXEC_XFCE_SESSION} >> ${XINITRC_PATH}
#  fi;
#  
#  sudo sed -i 's#allowed_users=.*$#allowed_users=anybody#' /etc/X11/Xwrapper.config
#}


########
# Main #
########
install_xfce
enable_sys_graphic

echo "-----"
