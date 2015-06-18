#!/bin/sh

usage() {
	if [ `whoami` != 'root' ]; 
		then echo "this script must be executed as root" && exit 1;
	fi
}
usage

gem uninstall deep_merge
gem uninstall hiera-gpg
rm $(puppet config print confdir)/hiera.yaml
rm -Rf $(puppet config print confdir)/hiera_data
rm -Rf /tmp/puppet-hiera-redbox
