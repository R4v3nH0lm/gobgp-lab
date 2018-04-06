#!/bin/bash
# Credit to Maxi Binder (https://github.com/mbndr/vagrant-golang) for providing the 99% of this script.

# Golang installation variables
VERSION="1.10"
OS="linux"
ARCH="amd64"

# Home of the vagrant user, not the root which calls this script
HOMEPATH="/home/ubuntu"

# Updating and installing stuff
echo "Updating and installing stuff ..."
sudo apt-get update -qq
sudo apt-get install -y -qq git curl lldpd

# Reload the lldpd service to make sure it is running.
echo "Restarting lldpd ..."
sudo service lldpd restart

if [ ! -e "/vagrant/go.tar.gz" ]; then
    # No given go binary
    # Download golang
    FILE="go$VERSION.$OS-$ARCH.tar.gz"
    URL="https://storage.googleapis.com/golang/$FILE"

    echo "Downloading $FILE ..."
    curl --silent $URL -o "$HOMEPATH/go.tar.gz"
else
    # Go binary given
    echo "Using given binary ..."
    cp "/vagrant/go.tar.gz" "$HOMEPATH/go.tar.gz"
fi;

echo "Extracting ..."
tar -C "$HOMEPATH" -xzf "$HOMEPATH/go.tar.gz"
mv "$HOMEPATH/go" "$HOMEPATH/.go"
rm "$HOMEPATH/go.tar.gz"

# Create go folder structure
GP="/vagrant/gopath"
mkdir -p "$GP/src"
mkdir -p "$GP/pkg"
mkdir -p "$GP/bin"

# Write environment variables, other prompt and automatic cd into /vagrant in the bashrc
echo "Editing .bashrc ..."
touch "$HOMEPATH/.bashrc"
{
    echo '# Prompt'
    echo 'export PROMPT_COMMAND=_prompt'
    echo '_prompt() {'
    echo '    local ec=$?'
    echo '    local code=""'
    echo '    if [ $ec -ne 0 ]; then'
    echo '        code="\[\e[0;31m\][${ec}]\[\e[0m\] "'
    echo '    fi'
    echo '    PS1="${code}\[\e[0;32m\][\u] \W\[\e[0m\] $ "'
    echo '}'

    echo '# Golang environments'
    echo 'export GOROOT=$HOME/.go'
    echo 'export PATH=$PATH:$GOROOT/bin'
    echo 'export GOPATH=/vagrant/gopath'
    echo 'export PATH=$PATH:$GOPATH/bin'

    echo '# Automatically change to the vagrant dir'
    echo 'cd /vagrant'
} >> "$HOMEPATH/.bashrc"

# Download and install gobgp & gobgpd
echo "Installing gobgp(d) ..."
GOBGPD="github.com/osrg/gobgp/gobgpd"
GOBGP="github.com/osrg/gobgp/gobgp"

export GOROOT="$HOMEPATH/.go"
export PATH=$PATH:$GOROOT/bin
export GOPATH=/vagrant/gopath
export PATH=$PATH:$GOPATH/bin

go get "$GOBGPD"
go get "$GOBGP"