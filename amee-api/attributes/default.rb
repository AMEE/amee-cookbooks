default[:amee_api][:approot] = "/var/www/apps"
default[:amee_api][:dirs] = {
                              "releases" => {},
                              "shared" => [
                                "crypto",
                                "log",
                                "pids",
                                "system"
                              ]
                            }
