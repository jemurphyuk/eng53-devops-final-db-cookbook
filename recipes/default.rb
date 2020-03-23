
include_recipe 'apt'
apt_update 'update_sources' do
  action :update
end

apt_update "update" do
  action :update
end

apt_repository 'mongodb-org' do
  uri 'http://repo.mongodb.org/apt/ubuntu'
  distribution 'xenial/mongodb-org/3.2'
  components ['multiverse']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key "EA312927"
end

package 'mongodb-org' do
  options '--allow-unauthenticated'
  action [:install, :upgrade]
end

service "mongod" do
  action [:enable, :start]
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  variables port: node['mongodb']['port'], bindIp: node['mongodb']['bindIp']
  notifies :restart, 'service[mongod]'
end
#
template '/lib/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  notifies :restart, 'service[mongod]'
end

template 'etc/metricbeat/metricbeat.yml' do
  source 'metricbeat.yml.erb'
  mode '777'
  owner 'root'
  group 'root'
end

execute 'fix_template' do
  command 'sudo chmod go-w /etc/metricbeat/metricbeat.yml'
end

execute 'enable_module_mongodb' do
  command 'sudo metricbeat modules enable mongodb'
end

execute 'enable_module_system' do
  command 'sudo metricbeat modules enable system'
end

#execute 'setup_dasboards' do
#  command 'sudo metricbeat setup'
#end

template 'etc/filebeat/filebeat.yml' do
  source 'filebeat.yml.erb'
  mode '777'
  owner 'root'
  group 'root'
end

execute 'fix_template' do
  command 'sudo chmod go-w /etc/filebeat/filebeat.yml'
end

execute 'enable_module_syslogs' do
  command 'sudo filebeat modules enable system'
end

#execute 'setup_dasboards' do
#  command 'sudo filebeat setup'
#end

service 'metricbeat' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

service 'filebeat' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
