#
# Cookbook Name:: amee-users
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group node['amee-api']['platform-owner'] do
  action :create
end

user node['amee-api']['platform-owner'] do
    system true
    guid node['amee-api']['platform-owner']
    shell "/bin/false"
  end
end
