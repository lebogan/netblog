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
db_dir=$HOME/netlog_db

prompt ()
{
  # See if the lame SYS-V echo command flags have to be used.
  if test "`/bin/echo 'helloch\c'`" = "helloch\c"
  then
    EFLAG="-n"
    ENDER=""
  else
    EFLAG=""
    ENDER="\c"
  fi
  ECHO="/bin/echo ${EFLAG}"

  ${ECHO} "$1 ${ENDER}"
  read agree
  if test "${agree}" = "y" -o "${agree}" = "Y"
  then
    echo ""
  else
    exit 1
  fi
}

# Links application to install_dir. If the symlink exists, offer to upgrade the app
# only and exit.
if [ ! -L ${install_dir}/netblog ]
then
  prompt "Do you want to install netblog? (y/n)[n] "
  sudo ln -s $(realpath ./netblog) $install_dir/netblog
  echo "netblog installed."
else
  prompt "Do you want to upgrade netblog? (y/n)[n] "
  git pull
  echo "netblog upgraded."
  exit 0
fi

# Check for existance of ${db_dir} and create it if it doesn't exist.
if [ ! -d ${db_dir} ]; then
  mkdir -p ${db_dir}
  cp ./config/netlog.db ${db_dir}
fi

# Export DATABASE_URL environment variable by adding it to the end of .bashrc.
grep -F -q "DATABASE_URL" ${HOME}/.bashrc
if [ "$?" -ne "0" ]; then
  echo "Setting DATABASE_URL environment variable"
  echo "export DATABASE_URL="sqlite3:${db_dir}/netlog.db"" >> $HOME/.bashrc
fi

# Export DB_DIR environment variable by adding it to the end of .bashrc.
grep -F -q "DB_DIR" ${HOME}/.bashrc
if [ "$?" -ne "0" ]; then
  echo "Setting DB_DIR environment variable"
  echo "export DB_DIR="${db_dir}"" >> $HOME/.bashrc
fi

# Create a secret to sign session ids before they are saved in cookies.
grep -F -q "SESSION_SECRET" ${HOME}/.bashrc
if [ "$?" -ne "0" ]; then
  echo "Setting SESSION_SECRET environment variable"
  echo "export SESSION_SECRET=`crystal eval 'require "random/secure"; puts Random::Secure.hex(64)'`" >> $HOME/.bashrc
fi

cat <<FINISH

--------------------------------------------------------------------------
Application, netblog, is now set up and ready to use. The database,
${db_dir}/netlog.db, is ready for use. The application, netblog, has
been installed in ${install_dir}. Make sure that is in your path.

Before first use, source the .bashrc file to export the DATABASE_URL
and DB_DIR environment variables.

Important: use the included shell script, backup_db.sh, to keep the 
database backed up and protected from oopsies! Use in a cron job.

Note: Debian/Ubuntu users have to recompile the binary. See the 
accompanying README.md file.
--------------------------------------------------------------------------
FINISH

