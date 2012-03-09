include_recipe "nginx"
include_recipe "rvm::unicorn"

user "#{node[:rails][:user]}" do
  home "/home/rails"
  shell "/bin/bash"
  supports :manage_home => true
  action :create
end

directory node[:dummy_app][:apps_dir] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

bash "Create dummy app" do
  code <<-ENDOFCRUFT
    source /etc/profile.d/rvm.sh
    rvm use #{node[:ruby][:default_version]}
    apt-get install sqlite3 libsqlite3-dev
    cd #{node[:dummy_app][:apps_dir]}
    rails new #{node[:dummy_app][:name]}
    chown -R #{node[:rails][:user]} #{node[:dummy_app][:name]}
    cd #{node[:dummy_app][:name]}
    gem install therubyracer --no-ri --no-rdoc
    echo "gem 'therubyracer'" >> Gemfile
    bundle install
  ENDOFCRUFT
end

template "upstart job" do
  path "/etc/init/#{node[:dummy_app][:name]}_unicorn.conf"
  source "unicorn_upstart.erb"
  variables ({
    :dir => "#{node[:dummy_app][:apps_dir]}#{node[:dummy_app][:name]}",
    :app_name => "#{node[:dummy_app][:name]}",
    :user => "#{node[:rails][:user]}",
    :version => "#{node[:ruby][:default_version]}"
  })
end

service "#{node[:dummy_app][:name]}_unicorn" do
  provider Chef::Provider::Service::Upstart
  action :start
end
#bash "Start service #{node[:dummy_app][:name]}_unicorn" do
#  code "service #{node[:dummy_app][:name]}_unicorn start"
#end

template "vhost" do
  path "#{node[:nginx][:dir]}/sites-available/#{node[:dummy_app][:name]}.conf"
  source "unicorn_vhost.erb"
  variables({
    :name => "#{node[:dummy_app][:name]}"
  })
end

link "#{node[:nginx][:dir]}/sites-enabled/#{node[:dummy_app][:name]}.conf" do
  to "#{node[:nginx][:dir]}/sites-available/#{node[:dummy_app][:name]}.conf"
end

service "nginx" do
  action :restart
end
