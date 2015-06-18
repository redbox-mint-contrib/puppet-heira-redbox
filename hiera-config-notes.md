#puppet-hiera-redbox
This is the hiera config for redbox.

## Pre-requisites

>classes: *These are the modules needed for the install - a convenience for anyone incorporating into site/nodes*

>directories: *Relative paths installed in puppet*

>exec_path: *Any exec references will use this array path to find native commands*

>install_parent_directory: *The parent directory for all installation subdirectories*

>deploy_parent_directory: *For use with any nexus archives pulled down, pre-installation. This is the parent directory for all deploy subdirectories*

>redbox_user: *The user for ownership and running of redbox/mint installation.*


>proxy:  *An array of reverse proxy configuration for apache* **(remember: order is important)**. Each array element contains:

>* path: * relative path under root.* **This should match context under redbox/mint jetty server. ** 

>* url: * the url to redirect to.* **In the example, below, note that your setting here should not be affected by whether or not SSL or DNS implemented.**
```
proxy:  
   - path: '/'  
     url: 'http://localhost:9000/'
```

>has_ssl: *boolean to determine whether to install SSL in apache* **Your proxy settings do not need to change. The only other setting to consider is ssl_config.**

>has_dns: *boolean whether to show IP or dns* **This will affect the browser url shown by apache as well as the redbox/mint server_url.**

>ssl_config: *hiera_hash needed for ssl_config. The file needs to be absolute path. If using content, consider using hiera-gpg and put this in separate encrypted file. If not using content, puppet will just expect the files to already be in place. Mode refers to file mode. If absent, set to 0444*
```
ssl_config:
  cert:
  	file:
    content: |
  key:
  	file:
    mode: 0400
    content: |
  chain:
  	file:
    content: |
```

>yum_repos:  * hiera_array, each element holding redbox yum package details. Currently only as below. Only useful if installing redbox as an rpm.*
```
yum_repos:
  - name: 'redbox'
    descr: 'Redbox_repo'
    baseurl: 'http://dev.redboxresearchdata.com.au/yum/releases'
    gpgcheck: 0
    enabled: 1
```

>crontab: * hiera_array settings needed for adding cron entry *
```
crontab:
  - name: 'deploy_redbox'
    user: 'root'
    command: "puppet apply -e \"class {'puppet-redbox':}\""
    hour: 2
    minute: 0
```

>tf_env: *The setting below opens up internal login, useful for development or local environments.*
```
tf_env:
   server_environment: dev
```

>packages: *hiera_hash of yum redbox packages to install. Used in combination with yum_repos*
```
packages:
  redbox:
    system: 'redbox'
    package: 'redbox-distro'
```

