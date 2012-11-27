# new cookbook defaults
cookbook_copyright        ENV['KNIFE_COOKBOOK_COPYRIGHT'] ||
                          %x{git config --get user.name}.chomp
cookbook_email            ENV['KNIFE_COOKBOOK_EMAIL'] ||
                          %x{git config --get user.email}.chomp
cookbook_license          "apachev2"