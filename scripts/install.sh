#!/bin/bash

usage() {
	if [ `whoami` != 'root' ]; 
		then echo "this script must be executed as root" && exit 1;
	fi
}
usage

echo "checking Puppet installed."
yum list installed puppet || exit 1

echo "installing gems required for hiera"
gem install deep_merge
sudo yum install -y ruby-devel
sudo yum install -y gcc
gem install hiera-gpg

echo "checking puppet-hiera-redbox cloned/copied to /tmp"
find /tmp -maxdepth 1 -iname "puppet-hiera-redbox" || exit 1

echo "checking puppet environment is set."
puppet config print environment || exit 1

echo "removing existing hiera data."
rm -Rf $(puppet config print confdir)/hiera_data

echo "copying hiera config into puppet."
mkdir $(puppet config print confdir)/hiera_data
mkdir $(puppet config print confdir)/hiera_data/secret
for f in hiera.yaml hiera_data/common.yaml hiera_data/$(puppet config print environment).yaml hiera_data/secret/$(puppet config print environment).gpg
do cp -u /tmp/puppet-hiera-redbox/${f} $(puppet config print confdir)/${f}
done
ls -l /etc/puppet/*

echo "cleaning up tmp"
rm -Rf /tmp/puppet-hiera-redbox

echo "Installation of hiera completed."
