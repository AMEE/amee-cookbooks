#
# Cookbook Name:: passenger
# Recipe:: default
#
# Copyright 2011, AMEE UK Ltd
#

# install these packages (apache2-dev and libcurl for building the apache module)
%w{apache2-dev libapache2-mod-passenger libcurl4-openssl-dev}.each do |cruft|
  package cruft do
    action :install
  end
end

# get this gem
bash "install passenger gem" do
  code "gem install passenger -v #{node[:passenger][:gem_version]}"
end

# build from source like it's 1999
bash "build the frickin' apache extension" do
  code <<-ENDOFCRUFT
    cd /usr/local/rvm/gems/ruby-1.9.2-p0/gems/passenger-3.0.11/ext/apache2
    rake apache2
  ENDOFCRUFT
end

# put in our custom conf files
template "passenger.conf" do
  path "/etc/apache2/mods-available/passenger.conf"
  source "passenger.conf.erb"
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

