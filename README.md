#puppet-hiera-redbox
This is the hiera config for redbox.

## Pre-requisites
*Tested only on CentOS 6 64-bit*

1.Install puppet:
```
sudo rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm && yum install -y puppet
```
2.Clone/copy puppet-hiera-redbox:

*NB: this is a private repo - you will either have to have a public ssh key copied up (for boxes in service environment) or clone to your own PC and scp to the box deploying to.*

```
sudo yum -y install git && git clone git@bitbucket.org:qcifltd/puppet-hiera-redbox.git /tmp/puppet-hiera-redbox && rm -Rf /tmp/puppet-hiera-redbox/.git
```


3.add/update **environment** in your puppet configuration file *(`sudo puppet config print config`)*. 

e.g: if you are deploying to your 'development' environment, then in your puppet config, add:
```
[main]
...
environment = development
```

## Install
`sudo /tmp/puppet-hiera-redbox/scripts/install.sh`

## TODO:
* split up repo to branch according to redbox-package, environment
* puppetize the install script and keep config as pure branched configuration repo.

### Template for use with secret-%<environment>.yaml:
```
---
ssl_config:
  cert:
  	file:
    content: |
  key:
  	file:
    content: |
  chain:
  	file:
    content: |

system_config:
  rapidAafSso:
    url: ""
    sharedKey: ""
    iss: ""
  api:
	clients: |
	   {
	      "" : {}
	   }

```
