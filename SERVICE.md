# netblog.service installation

## Edit the included service file
The ◄ symbol marks the places which need editing. The installation created a random
64-bit secret. Use export to get it and paste it into the service file.
```bash
$ export | grep SESSION_SECRET
```

```
[Unit]
Description=Netblog maintenance logger
After=network.target

[Service]
Type=simple

# Preferably configure a non-privileged user
User=<username> ◄
Group=<usergroup> ◄

# The path to the application root, i.e., /home/<username>/netblog
# This loads all public assets such as css, javascript, images, etc.
WorkingDirectory=/home/<username>/netlog  ◄

# Environment variables
Environment=DB_DIR=path_to_database ◄
Environment=DATABASE_URL=sqlite3:fully_qualified_path_to_database ◄
Environment=SESSION_SECRET=the_secret_from_your_bashrc ◄

PIDFile=/tmp/netblog.pid

# The command to start the service - this is a symbolic link to the executable in
# the installation directory.
ExecStart=/usr/local/bin/netblog

TimeoutSec=30
RestartSec=15s
Restart=always

[Install]
WantedBy=multi-user.target

```

## Copy the file to the service directory
```
$ sudo cp netblog.service /etc/systemd/system/netblog.service
```

## Reload the service daemon
```
$ sudo systemctl daemon-reload
```

## Start and enable the service
```
$ sudo systemctl start netblog.service
$ sudo systemctl enable netblog.service
```

## Troubleshoot
Use journalctl or systemctl status to see what went wrong
```
$ journalctl -xe
or
$ sudo systemctl status netblog.service
```

## This is what mine looks like
```
[Unit]
.
.
.
# Preferably configure a non-privileged user
User=vagrant
Group=vagrant

# The path to the application root. In development, it is /vagrant/Projects/crystal/kemal_apps/netblog
# For production, it is /opt/netblog
WorkingDirectory=/vagrant/Projects/crystal/kemal_apps/netblog

Environment=DB_DIR=/vagrant/Projects/crystal/kemal_apps/netblog/config
Environment=DATABASE_URL=sqlite3:/vagrant/Projects/crystal/kemal_apps/netblog/config/netlog.db
Environment=SESSION_SECRET="Shhhhh! It's a secret"

PIDFile=/home/vagrant/tmp/netblog.pid
.
.
.
```

