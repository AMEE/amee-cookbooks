name "amee-platform"
description "AMEE Platform node"
run_list "recipe[java]",
         "recipe[apache2]",
         "recipe[apache2::mod_proxy]",
         "recipe[apache2::mod_proxy_http]",
         "recipe[amee-api::system-users]",
         "recipe[amee-api::directories]"
