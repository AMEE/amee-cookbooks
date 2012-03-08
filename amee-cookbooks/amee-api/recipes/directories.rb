approot = "/var/www/apps"

dirs = {
  "releases" => {},
  "shared" => [
    "crypto",
    "log",
    "pids",
    "system"
  ]
}

def mkdir dir, owner = node['amee-api']['platform-owner']
  directory dir do
    owner owner
    group owner
    mode "0755"
    action :create
  end
end

mkdir approot, "root"

platform_root = "#{approot}/#{node['amee-api']['platform-root']}"

mkdir platform_root

dirs.keys.each do |dir|
  mkdir "#{platform_root}/#{dir}" 
  dirs[dir].each do |subdir|
    mkdir "#{platform_root}/#{dir}/#{subdir}"
  end
end
