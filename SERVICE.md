# netblog.service installation

## Copy the file to the service directory
```
$ sudo cp netblog.service /etc/systemd/system/netblog.service
```

## Edit using a text editor
The ◄ symbol marks the places which need editing. The installation created a random
64-bit secret. Use export to get it and paste it into the service file.
```bash
$ export | grep SESSION_SECRET
```

```
[Unit]
Description=Netblog maintenance logger front-end
After=network.target

[Service]
Type=simple

# Preferably configure a non-privileged user
User=<username> ◄
Group=<usergroup> ◄

# The absolute path to the application root, i.e., /home/<username>/netblog
# This loads all public assets such as css, javascript, images, etc.
WorkingDirectory=/home/<username>/netlog  ◄

# Environment variables
Environment=DATABASE_URL=postgresql://<user>:<password>@<dbhost>:5432/netlog ◄
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

## Reload the service daemon
```
$ sudo systemctl daemon-reload
```

## Edit using systemctl; no need to do a daemon-reload
```
$ sudo systemctl edit netblog.service --full
```

## Start and enable the service
```
$ sudo systemctl start netblog.service
$ sudo systemctl enable netblog.service
```

## Troubleshoot
Use journalctl or systemctl status to see what went wrong.
```bash
$ journalctl -xe

or:

$ sudo systemctl status netblog.service
```

Expect SELinux to complain about everything. Either disable it or add netblog
to the policy.
```bash
SELinux:
$ sudo ausearch -c 'netblog' --raw | audit2allow -M my-netblog
$ sudo semodule -i my-netblog.pp

or:

$ sudo setenforce 0 <one shot>

or:

edit /etc/selinux/config and set SELINUX=permissive
```

## This is what mine looks like on my development box
```
[Unit]
.
.
.
# Preferably configure a non-privileged user
User=vagrant
Group=vagrant

# The path to the application root. In development, it is /vagrant/Projects/crystal/kemal_apps/netblog
WorkingDirectory=/vagrant/Projects/crystal/kemal_apps/netblog

Environment=DB_DIR=/vagrant/Projects/crystal/kemal_apps/netblog/config
Environment=DATABASE_URL=sqlite3:/vagrant/Projects/crystal/kemal_apps/netblog/config/netlog.db
Environment=SESSION_SECRET="Shhhhh! It's a secret"

PIDFile=/home/vagrant/tmp/netblog.pid
.
.
.
```

