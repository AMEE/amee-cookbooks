#
# Cookbook Name:: passenger
# Recipe:: default
#
# Copyright 2011, AMEE UK Ltd
#

%w{apache2-dev libapache2-mod-passenger libcurl4-openssl-dev}.each do |cruft|
  package cruft do
    action :install
  end
end

bash "install passenger gem" do
  code "gem install passenger -v #{node[:passenger][:gem_version]}"
end

bash "build the frickin' apache extension" do
  code <<-ENDOFCRUFT
    cd /usr/local/rvm/gems/ruby-1.9.2-p0/gems/passenger-3.0.11/ext/apache2
    rake apache2
  ENDOFCRUFT
end

template "passenger.conf" do
  path "/etc/apache2/mods-available/passenger.conf"
  source "passenger.conf.erb"
#  variables(
#    :ruby_version => node[:ruby][:version],
#    :passenger_gem => node[:passenger][:gem_version]
#  )
  owner "root"
  group "root"
  mode 0644
end

template "passenger.load" do
  path "/etc/apache2/mods-available/passenger.load"
  source "passenger.load.erb"
  owner "root"
  group "root"
  mode 0644
end

