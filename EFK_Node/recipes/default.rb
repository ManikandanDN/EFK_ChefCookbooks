#
# Cookbook:: EFK_Node
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

yum_repository 'elasticsearch' do
  description 'Elastic Stack repository for 6.x packages'
  baseurl 'https://artifacts.elastic.co/packages/6.x/yum'
  gpgcheck true
  gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  enabled true
  action :create
end

yum_package 'java-1.8.0-openjdk' do
  action :install
end

yum_package 'elasticsearch' do
  action :install
  flush_cache [ :before ]
end

service 'elasticsearch' do
  action [ :enable, :start ]
end


yum_package 'ntp' do
  action :install
end

service 'ntpd' do
  action [:enable, :start]
end

bash 'install_fluentd' do
  user 'root'
  cwd '/usr'
  code <<-EOH
  curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh
  /usr/sbin/td-agent-gem install fluent-plugin-secure-forward
  /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch
  EOH
end


service 'td-agent' do
  action [:enable, :start]
end
