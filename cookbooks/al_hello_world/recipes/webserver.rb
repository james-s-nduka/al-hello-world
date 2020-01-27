#
# Cookbook Name:: al_hello_world
# Recipe:: webserver
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

# Install nginx
package 'nginx' do
  action :install
end

# nginx configuration
template '/etc/nginx/nginx.conf' do
  source 'web-nginx.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[nginx]'
end

# Web page to serve
template '/usr/share/nginx/html/index.html' do
  source 'web-index.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[nginx]'
end

# deploy web page in avilable sites
template '/etc/nginx/sites-available/default' do
  source 'web-index.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

link '/etc/nginx/sites-available/default' do
  to '/etc/nginx/sites-enabled/default'
  link_type :hard
end

# Ensure nginx is started and enabled
service 'nginx' do
  action [:enable, :start]
end
