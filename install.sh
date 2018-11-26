#!/bin/bash

# +-------------------------------------------
# |
# | V1 - 02 Novembro 2018
# | - Install Docker Debian Stretch X64
# | - Install Python3 and PIP3
# | - Install
# |
# | V2 - 16 Novembro 2018
#	| - Start AGO
# | - Stop AGO
# |
# | V3 - 26 Novembro 2018
#	| - Install Virtualbox
# | - Stop AGO
# +-------------------------------------------

function help() {
  echo "sudo $0 -h [HELP]"
  echo "sudo $0 -v [VERSION]"
  echo "sudo $0 --install-debianx64"
  echo "sudo $0 --start-ago"
  echo "sudo $0 --stop-ago"
}

function versao() {
  echo "Versão 0.1DEV"
}

function manual() {
  echo "Manual"
}
# +-------------------------------------------
# | FUNCTIONS -
# | - update_repository_apt (update repository APT Debian and Ubuntu)
# | - git_install (install git)
# | - install_python3_pip3 (install python3 e pip3)
# | - install_docker_debian_x64 (install docker for debian stretch x64)
# | - install_pip_lib_docker_compose (install libs for docker using PIP and Python3)
# | - install_debian_x64 ([MENU ] --install-debianx64 responsible for the installation (update repository,install python3,pip3,docker,docker-compose,docker))
# | -
# | -
# +-------------------------------------------

# function update
function update_repository_apt() {
  #update
  apt-get update -y
}

function git_install() {
  apt-get install git -y
}

# function install python3 e pip3
function install_python3_pip3() {
  #install python3
  apt-get install python3 -y
  #install pip3
  apt-get install python3-pip -y
}


function install_docker_debian_x64() {
  #update repository
  update_repository_apt
  apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
  apt-key fingerprint 0EBFCD88
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
  #update repository
  update_repository_apt
  apt-get install docker-ce -y
}


# install PIP3 lib docker and docker-compose
function install_pip_lib_docker_compose() {
  update_repository_apt
  install_python3_pip3
  pip3 install docker-compose
  pip3 install docker
}



function install_debian_x64() {
  # Atualiza repositorio
  atualiza_repositorio_apt
  # install git
  git_install
  # Install Docker for Debian
  install_docker_debian_x64
  # Install python3 and pip3
  install_python3_pip3
  # LIB docker
  install_pip_lib_docker_compose
}

function start_ago_project() {
  docker-compose up -d
}

function stop_ago_project() {
  docker rm vidafacil_mysql vidafacil_mongo vidafacil_phpmyadmin vidafacil_api -f
}

function install_debian_x64_virtualbox() {
  apt-add-repository 'deb https://download.virtualbox.org/virtualbox/debian stretch contrib'
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  apt-get update
  apt-get install virtualbox-5.0 -y
  wget https://download.virtualbox.org/virtualbox/5.0.40/Oracle_VM_VirtualBox_Extension_Pack-5.0.40.vbox-extpack
  VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-5.0.40.vbox-extpack
}

# ADD MOD Shiva Linux
# work area
# login
# grub
# msg modify
function work_area_shiva() {
  mv /usr/share/images/desktop-base/desktop-background /usr/share/images/desktop-base/desktop-background-BKP
  mv /usr/share/images/desktop-base/default /usr/share/images/desktop-base/default-BKP
  mv lord-shiva.png /usr/share/images/desktop-base/desktop-background
  cp /usr/share/images/desktop-base/desktop-background /usr/share/images/desktop-base/default
}
function login_shiva() {
  mv /usr/share/images/desktop-base/login-background.svg /usr/share/images/desktop-base/login-background-BKP.svg
  mv login.svg /usr/share/images/desktop-base/login-background.svg
}
function grub_shiva() {
  mv /usr/share/images/desktop-base/desktop-grub.png /usr/share/images/desktop-base/desktop-grub-BKP.png
  mv grub.jpg /usr/share/images/desktop-base/desktop-grub.png
}
function msg_shiva() {
  NEW_MSG = "ShivaLinux init version \n Using Debian Stretch \n Debian is Love s2"
  mv /etc/motd /etc/motd-BKP
  echo $NEW_MSG > /etc/motd
}

case $1 in
  -h )
    help
    ;;
  -V )
    versao
    ;;
  -m )
    manual
    ;;
  --install-debianx64 )
    install_debian_x64
    ;;
  --start-ago )
    start_ago_project
    ;;
  --stop-ago )
    stop_ago_project
    ;;
  *)
    echo Opção inválida: $1
    help
    exit 0
    ;;
esac
