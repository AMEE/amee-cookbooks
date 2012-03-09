bash "Install unicorn" do
  code <<-ENDOFCRUFT
    source /etc/profile.d/rvm.sh
    rvm use #{node[:ruby][:default_version]}
    gem install unicorn --no-ri --no-rdoc
  ENDOFCRUFT
end 
