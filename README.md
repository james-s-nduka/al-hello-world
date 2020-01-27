# Automation Logic Hello World Load Balancer Test

Configuration of the Hello World app for Load-Balanced Round Robin Demonstration.

### Prereqisties
- Installation of Vagrant (Latest version)
- Installation of VirtualBox (Latest version)

## Steps

1. Run `vagrant up` in a shell whilst in the root of this folder
2. Enter http://localhost on your browser
3. Hit referesh to witness round-robin loadbalancing on the web servers

## Testing
This project uses *Test Kitchen* as the framework for Test-Driven-Development. You can find the Inspec tests in `./cookbooks/al_hello_world/test` directory. In order to run from within the cookbook "al_hello_world";


1. Run `kitchen verify <TEST SUITE>`
   - TEST SUITE is either; `webserver-1-ubuntu-bionic64`, `webserver-2-ubuntu-bionic64` or `loadbalancer-ubuntu-bionic64`
   - This will converge a new Test Kitchen machine in Vagrant. You can launch all 3 machines by just executing `kitchen verify`

2. Run `kitchen destroy` to shutdown and delete all the test instances created from the verify


3. You can run `kitchen verify` with no arguments to spin up all the machines and test each in one go.


# Potential Improvements
1. The webserver machines IP's could be captured in a collection and used in the Chef template in order to create the `nginx.conf` on the loadbalancer without hardcoded values
2. A Jenkinsfile could be part of the project in order to leverage CI/CD
3. A richer Web app (GO, PHP) could be deployed and a MySQL DB backend machine could be provisioned and configured as part of this project


## License and Authors
Authors: James Nduka
