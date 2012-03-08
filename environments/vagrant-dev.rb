name "vagrant-dev"
description "For testing Chef cookbooks on disposable Vagrant nodes"

default_attributes "fail2ban" => { "whitelist" => [ "123.123.123.123" ] }
