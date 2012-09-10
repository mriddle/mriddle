directory Chef::Config[:file_cache_path] do
  owner node[:users][:admin]
  group "admin"
  mode "0755"
end

ohai "reload" do
  action :nothing
end

include_recipe "apt"

service "rsyslog"

include_recipe "logrotate"


