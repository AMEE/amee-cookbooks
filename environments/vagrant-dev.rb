name "vagrant-dev"
description "For testing Chef cookbooks on disposable Vagrant nodes"

default_attributes "amee-api" => { "platform-suffix" => "vagrant" }
