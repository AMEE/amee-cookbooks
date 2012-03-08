name "amee-feynman"
description "AMEE Platform v3"
default_attributes "amee-api" => {
                                    "platform-root" => "platform-api",
                                    "platform-owner" => "platform-api"
                                 }
run_list "role[amee-platform]"
