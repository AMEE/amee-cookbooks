#default[:rvm][:version]     = "1.0.1"
#default[:rvm][:archive]     = "rvm-#{rvm[:version]}"
#default[:rvm][:tarball]     = "#{rvm[:archive]}.tar.gz"
#default[:rvm][:tarball_url] = "http://rvm.beginrescueend.com/releases/#{rvm[:tarball]}"

default[:rvm][:installer_url] = "https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer"
#default[:ruby][:version]    = "1.9.2-p0"
#default[:ruby][:version]    = "1.8.7"
#default[:rails][:version]   = "3.1.3"
#default[:rails][:version]   = "2.3.14"

default[:ruby_rails][:versions] = {
  "1.9.2" => "3.1.3",
  "ree" => "2.3.14"
}

default[:ruby][:default_version] = "1.9.2"

default[:dummy_app][:apps_dir] = "/var/www/apps/"
default[:dummy_app][:name] = "dummy_app.cruft"

default[:rails][:user] = 'rails'
