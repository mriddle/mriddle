#for apt-add-repository
package 'python-software-properties'

timestamp_file = '/var/lib/apt/periodic/update-success-stamp'
must_be_updated_since = Time.now - 86400 * 5 # 5 days ago

%w{/var/cache/local /var/cache/local/preseeding /var/lib/apt/periodic}.each do |dirname|
  directory dirname do
    owner "root"
    group "root"
    mode  '755'
    action :create
  end
end

execute "apt-get update" do
  user 'root'
  command <<-BASH
    apt-get update
    touch #{timestamp_file}
  BASH
  ignore_failure true
  action :nothing
end

bash "apt-get-update-periodic" do
  code 'echo apt hasnt been updated in a while'
  notifies :run, resources(:execute => "apt-get update"), :immediately
  only_if do
    (!(File.exists? timestamp_file)) || File.mtime(timestamp_file) < must_be_updated_since
  end
end



