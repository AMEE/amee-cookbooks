include_recipe "rvm::dependencies"
include_recipe "rvm::install"
include_recipe "rvm::install_rubies"

### #
### # Cookbook Name:: rvm
### # Recipe:: default
### #
### # Copyright 2011, AMEE UK Ltd
### #
### # Took this http://beekl.es/b3 and Cheffed it - I get the feeling other people
### # might find this useful
### #
### # I presume it needs 1.8.7 to bootstrap 1.9, but to be honest, I'm cargo-culting a lot of this
### 
### # we need curl to download the archive
### %w{curl git-core}.each do |cruft|
###   package cruft do
###     action :install
###   end
### end
### 
### # grab the remote file
### remote_file "#{Chef::Config[:file_cache_path]}/#{node[:rvm][:tarball]}" do
###   source "#{node[:rvm][:tarball_url]}"
###   action :create_if_missing
### end
### 
### # untar and install like it's 1999
### bash "install rvm" do
###   cwd Chef::Config[:file_cache_path]
###   code <<-ENDOFCRUFT
###     tar xzf #{node[:rvm][:tarball]}
###     cd #{node[:rvm][:archive]}
###     ./install  
###   ENDOFCRUFT
### end
### 
### # more packages required
### %w{libruby1.8 zlib1g-dev libssl-dev libreadline5-dev build-essential}.each do |cruft|
###   package cruft do
###     action :install
###   end
### end
### 
### # rvm-install 1.8.7 - not if it's already there (these builds take a looong time)
### bash "install ruby 1.8.7" do
###   code <<-ENDOFCRUFT
###     [ ! "`rvm list | grep 1.8.7`" ] && rvm install ruby-1.8.7 ; rvm use ruby-1.8.7 --default
###   ENDOFCRUFT
### end
### 
### # install yet more things
### #%w{ruby rubygems irb ri rdoc rake ruby1.8-dev libopenssl-ruby}.each do |cruft|
### %w{rubygems irb ri rdoc rake ruby1.8-dev libopenssl-ruby}.each do |cruft|
###   package cruft do
###     action :install
###   end
### end
### 
### # now we can install 1.9.n - not if it's already there
### bash "install ruby #{node[:ruby][:version]}" do
###   code <<-ENDOFCRUFT
###       [ ! "`rvm list | grep #{node[:ruby][:version]}`" ] && rvm install ruby-#{node[:ruby][:version]} ; rvm use ruby-#{node[:ruby][:version]} --default
###   ENDOFCRUFT
### end
### 
### # then install rails (we do this via a bash line because gem_install seems to use the system ruby or something. It's a hack, but it works)
### bash "install rails" do
###   code "gem install rails --version #{node[:rails][:version]}"
### end
### 
### # something something something rvm. The rails binary does not go somewhere sensible like /usr/local/bin, so we use a symlink (could not get update-alternatives to play nice)
### bash "put rails on the path" do
###   code "ln -sf /usr/local/rvm/gems/ruby-#{node[:ruby][:version]}*/gems/rails-#{node[:rails][:version]}/bin/rails /usr/local/bin/"
### end
### 
### # and again
### bash "put bundle on the path" do
###   code "ln -sf /usr/local/rvm/gems/ruby-#{node[:ruby][:version]}*/gems/bundler-*/bin/bundle /usr/local/bin/"
### end
