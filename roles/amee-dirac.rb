name "amee-dirac"
description "AMEE Platform v2"
default_attributes "amee-api" => {
                                    "platform-root" => "amee",
                                    "platform-owner" => "amee"
                                 }
run_list "role[amee-platform]"
