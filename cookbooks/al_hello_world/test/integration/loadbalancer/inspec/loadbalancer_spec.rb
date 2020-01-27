# # encoding: utf-8

# Inspec test for recipe al_hello_world::loadbalancer

# Is the webapp installed?
describe package('nginx') do
  it { should be_installed }
  its('version') { should match /1\.14\..*/ }
end

# server up and running?
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

# Are you listening on the correct port?
describe port(80) do
  it { should be_listening }
end
