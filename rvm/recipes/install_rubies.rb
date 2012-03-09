#bash "Install a Ruby" do
#  code <<-ENDOFCRUFT
#    source /etc/profile.d/rvm.sh
#    rvm install ree
#  ENDOFCRUFT
#end

#gem "chef" do
#  action :install
#end

node[:ruby_rails][:versions].each do |ruby, rails|
  bash "Install Ruby #{ruby}, Rails #{rails}" do
    code <<-ENDOFCRUFT
      source /etc/profile.d/rvm.sh
      rvm install #{ruby}
      rvm use #{ruby}
      gem install rails -v #{rails} --no-ri --no-rdoc
      gem install chef --no-ri --no-rdoc
    ENDOFCRUFT
  end
  bash "Set default Ruby" do
    code <<-ENDOFCRUFT
      source /etc/profile.d/rvm.sh
      rvm default #{node[:ruby][:default_version]}
    ENDOFCRUFT
  end
end
