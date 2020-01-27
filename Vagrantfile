# -*- mode: ruby -*-
# vi: set ft=ruby :
webservers = 2
chef_version = '14.12.9'

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/bionic64'
  config.vm.synced_folder '.', '/vagrant', type: 'virtualbox'

  # Define vb specific params
  config.vm.provider 'virtualbox' do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
    # Customize the amount of memory on the VM:
    vb.memory = '1024'
  end

  # Give me 2 Web Servers with the same configuration
  (1..webservers).each do |i|
    config.vm.define "webserver-#{i}" do |web|
      web.vm.network 'private_network', ip: "192.168.50.1#{i}"
      web.vm.network 'forwarded_port', guest: 80, host: "808#{i}"
      web.vm.hostname = "webserver-#{i}"
      web.vm.provision 'chef_solo' do |chef|
        chef.version = chef_version
        chef.json = {
          'al_hello_world' => {
            'web_port' => '80'
          }
        }
        chef.run_list = ['recipe[al_hello_world::webserver]']
      end
    end
  end

  # Give me a single Load-Balancer listening on port 80
  config.vm.define 'lb' do |lb|
    lb.vm.network 'forwarded_port', guest: 80, host: 80
    lb.vm.network 'private_network', ip: '192.168.50.20'
    lb.vm.hostname = 'loadbalancer.vagrant.vm'
    lb.vm.provision 'chef_solo' do |chef|
      chef.version = chef_version
      chef.json = {
        'al_hello_world' => {
          'lb_port' => '80',
          'web_port' => '80'
        }
      }
      chef.run_list = ['recipe[al_hello_world::loadbalancer]']
    end
  end
end
