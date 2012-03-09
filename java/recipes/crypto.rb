path = "#{node[:amee_api][:approot]}/#{node['amee-api']['platform-root']}-#{node.chef_environment}/shared/crypto"
%w{key salt}.each do |file|
  cookbook_file "#{path}/amee.#{file}" do
    source "amee.#{file}"
    owner node['amee-api']['platform-owner']
    group node['amee-api']['platform-owner']
    mode "0644"
  end
end
