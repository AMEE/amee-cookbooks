approot = "/var/www/apps"

rootdirs = {
  "amee", 
  "platform"
}

dirs = {
  "releases",
  "shared" = {
    "crytpo",
    "log",
    "pids",
    "system"
  }
}

directory approot do
  owner "root"
  group "root"
  mode "0755"
  action :create
end
