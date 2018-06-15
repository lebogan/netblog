# netblog

Netblog, or NetLog, is a web-based network maintenance log book. It
is actually a re-write of my command-line utility, netblog.

## Installation
```bash
$ git clone https://github.com/lebogan/netblog.git
    or
$ git clone git@bitbucket.org:lebogan/netblog.git
$ cd netblog
$ ./install.sh
$ source ~/.bashrc (one time only)
```
The installation script will symbolically link the program, netblog, to the
location, /usr/local/bin. The empty database is installed in $HOME/netblog_db.
An environment variable, DATABASE_URL, is added to .bashrc for exporting 
into the user's session. Either `source .bashrc` or log out and back in. This 
is how the application finds the database.

To update, just run ***install.sh*** in the netblog directory. The script pulls a fresh
copy from GitHub and since the app is symbolically linked, you're finished.

For completeness, a backup script, backup_db.sh, is provided to both backup the
entire database in a .bak file and dump the main table into a .sql file.
These files are timestamped and maybe should be committed to a 
source repository like git. Add this script to cron for automation.

Additionally, since the backup files can grow over time, files older than 90 days
are deleted after the current backup process runs. You are prompted for a decision
whether to delete those files.


## Usage

TODO: Write usage instructions here

## TODO

## Development

Please, see the Disclaimer below.

## Contributing

1. Fork it ( https://github.com/[your-github-name]/netblog/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors
- [lebogan](https://github.com/lebogan/netblog.git) - creator, maintainer

## License
This utility is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

## Disclaimer
This utility was originally created for personal use in my work as a network
specialist. It was developed on a virtual Fedora Workstation using Crystal 0.24.2.
This has been tested on Fedora 26/27 Workstation.

I am not a professional software developer nor do I pretend to be. I am a **retired** IT 
network specialist and this is a hobby to keep me out of trouble. If you 
use this application and it doesn't work the way you would want, feel free to 
fork it and modify it to your liking. Fork on GitHub at https://github.com/lebogan/netblog.git
