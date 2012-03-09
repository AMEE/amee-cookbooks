def mkdir dir, owner = node['amee-api']['platform-owner']
  directory dir do
    owner owner
    group owner
    mode "0755"
    action :create
  end
end

mkdir node[:amee_api][:approot], "root"

platform_root = "#{node[:amee_api][:approot]}/#{node['amee-api']['platform-root']}-#{node.chef_environment}"

mkdir platform_root

dirs = node[:amee_api][:dirs]
dirs.keys.each do |dir|
  mkdir "#{platform_root}/#{dir}" 
  dirs[dir].each do |subdir|
    mkdir "#{platform_root}/#{dir}/#{subdir}"
  end
end
