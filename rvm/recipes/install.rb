bash "Install rvm" do
  code "bash -s stable < <(curl -s #{node[:rvm][:installer_url]})"
end

group "rvm" do
  members ['root']
end

bash "Run profile snippet" do
  code "source /etc/profile.d/rvm.sh"
end
