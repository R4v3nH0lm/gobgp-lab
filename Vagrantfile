Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.define "gobgp_router1" do |gobgp_router1|
    gobgp_router1.vm.box = "ubuntu/xenial64"
    gobgp_router1.vm.hostname = "gobgp-router1"
    gobgp_router1.vm.network "private_network", virtualbox__intnet: "swp1", ip: "192.168.0.1/30"
    # gobgp_router1.vm.network "private_network", virtualbox__intnet: "swp2"
    # gobgp_router1.vm.network "private_network", virtualbox__intnet: "swp3"
    # gobgp_router1.vm.network "private_network", virtualbox__intnet: "swp4"
    gobgp_router1.vm.provision "shell", path: "bootstrap.sh"
  end

  config.vm.define "gobgp_router2" do |gobgp_router2|
    gobgp_router2.vm.box = "ubuntu/xenial64"
    gobgp_router2.vm.hostname = "gobgp-router2"
    gobgp_router2.vm.network "private_network", virtualbox__intnet: "swp1", ip: "192.168.0.2/30"
    # gobgp_router2.vm.network "private_network", virtualbox__intnet: "swp2"
    # gobgp_router2.vm.network "private_network", virtualbox__intnet: "swp3"
    # gobgp_router2.vm.network "private_network", virtualbox__intnet: "swp4"
    gobgp_router2.vm.provision "shell", path: "bootstrap.sh"
  end

end
