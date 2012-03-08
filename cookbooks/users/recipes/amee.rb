### users = [ 'sam' ]
### 
### users.each do |u|
###   homedir = "/home/#{u}"
###   user u do
###     gid "admin"
###     home "#{homedir}"
###     shell "/bin/bash"
###     supports :manage_home => true
###     action :create
###   end
### 
###   directory "#{homedir}/.ssh" do
###     owner u
###     mode "0700"
###   end
### 
###   template "#{homedir}/.ssh/authorized_keys" do
###     source "authorized_keys.erb"
###     owner u
###     mode "0600"
###     variables :ssh_keys => data_bag_item("users", u)['public_keys']
###   end
### end
### 
### template "/home/deploy/.ssh/authorized_keys" do
###   action :nothing
### end

users_manage "amee" do
  action [ :remove, :create ]
end
