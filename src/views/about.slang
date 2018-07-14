section.container-fluid.well style="height: 500px"
  - kemal_version = ""
  - Netblog::KEMAL_VERSION.each do |line|
    - if line.match(/kemal \(/)
      - kemal_version = line.gsub(/kemal/, "").gsub(/\*/, "")
  p  NetBLog #{Netblog::VERSION}, a simple browser interface to maintenance log, netlog.db.
  p  Executable symlink: /usr/local/bin/netblog
  p  Database location: $HOME/netlog_db
  p  Built using the Crystal programming language (#{Crystal::VERSION}) and Kemal Web Framework #{kemal_version}. 
  p  Distributed under the MIT License, http://opensource.org/licenses/MIT.
  p  Creater, maintainer: lebogan <lewis.bogan@comcast.net>
