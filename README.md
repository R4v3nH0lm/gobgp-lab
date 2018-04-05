# gobgp-lab

## Setup ##

### Required Software ###
Download and install VirtualBox.
Download and install Vagrant.

#### Vagrant ####
This will require the following vagrant boxes be available on your system:
- ubuntu/xenial64

#### VirtualBox ####
The VM running napalm will require atleast 1024MB to run or else napalm will fail to compile during pip install.

## Tree ##
.
├── README.md
├── Vagrantfile
└── bootstrap.sh