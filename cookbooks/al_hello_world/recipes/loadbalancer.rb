#
# Cookbook Name:: al_hello_world
# Recipe:: loadbalancer
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

# Net tools for nework diagnostics etc
package 'net-tools' do
  action :install
end

# Install nginx
package 'nginx' do
  action :install
end

# nginx configuration
template '/etc/nginx/nginx.conf' do
  source 'lb-nginx.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[nginx]'
end

# Ensure nginx is started and enabled
service 'nginx' do
  action [:start, :enable]
end
