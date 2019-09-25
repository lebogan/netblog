#!/usr/bin/env bash
#===============================================================================
#
#         FILE:  install.sh
#        USAGE:  install.sh
#  DESCRIPTION:  Installs netblog application and database.
#
#      OPTIONS:  ---
# REQUIREMENTS:
#
#         BUGS:  ---
#        NOTES:  #
#       AUTHOR:  Lewis E. Bogan
#      COMPANY:  Earthsea@Home
#      CREATED:  2018-02-19 13:51
#    COPYRIGHT:  (C) 2018 Lewis E. Bogan <lewis.bogan@comcast.net>
# Distributed under terms of the MIT license.
#===============================================================================
install_dir=/usr/local/bin

show_menu()
{
  local choice

  clear
  echo "--------------------------------------------------"
  echo "Installation script for netblog utility"
  echo "--------------------------------------------------"
  echo "1. Install supplied binary (Fedora only) - DEPRECIATED"
  echo "2. Update supplied binary from repo (Fedora only) - DEPRECIATED"
  echo "3. Build/install from source"
  echo "4. Update from git source"
  echo "5. Uninstall all (except data files)"
  echo "q. Quit"
  echo

  read -p "Enter choice [Q/q to quit]: " choice
  case $choice in
    1) install_binary ;;
    2) update_binary ;;
    3) build_source ;;
    4) update_source ;;
    5) uninstall_all ;;
    "q" | "Q") exit 0 ;;
  esac
}

install_binary()
{
  sudo ln -s $(realpath ./netlog) $install_dir/netblog
  db_setup
  source ~/.bashrc
  finish_msg
}

update_binary()
{
  git pull
  echo "netblog binary upgraded."
  exit 0
}

build_source()
{
  shards install
  make clean
  make
  sudo make install
  db_setup
  source ~/.bashrc
  finish_msg
}

update_source()
{
  git pull
  shards update
  make clean
  make
  sudo make install
  echo "netblog updated from source"
}

uninstall_all()
{
  sudo make uninstall
  sed -i.bak '/NETBLOG_DATABASE_URL/d' ~/.bashrc
  sed -i.bak '/NETBLOG_SESSION_SECRET/d' ~/.bashrc
  source ~/.bashrc
}

db_setup()
{
  # Export NETBLOG_DATABASE_URL environment variable by adding it to the end of .bashrc.
  grep -F -q "NETBLOG_DATABASE_URL" ${HOME}/.bashrc
  if [ "$?" -ne "0" ]; then
    echo "Setting NETBLOG_DATABASE_URL environment variable"
    echo "export NETBLOG_DATABASE_URL="postgresql://dbuser:dbuser@dbserver2:5432/netlog"" >> $HOME/.bashrc
  fi
  
  # Create a secret to sign session ids before they are saved in cookies.
  grep -F -q "NETBLOG_SESSION_SECRET" ${HOME}/.bashrc
  if [ "$?" -ne "0" ]; then
    echo "Setting NETBLOG_SESSION_SECRET environment variable"
    echo "export NETBLOG_SESSION_SECRET=`crystal eval 'require "random/secure"; puts Random::Secure.hex(64)'`" >> $HOME/.bashrc
  fi
}

finish_msg()
{
  cat <<FINISH

--------------------------------------------------------------------------
Application, netblog, is now set up and ready to use.

Before first use, source the .bashrc file to export the DATABASE_URL and
the SESSION_SECRET environment variables.
--------------------------------------------------------------------------
FINISH
}

show_menu
