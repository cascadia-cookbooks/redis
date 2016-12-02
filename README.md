# redis Cookbook
This cookbook will install Redis Server.

## Requirements
### Supported Platforms
* ubuntu/xenial64
* ubuntu/trusty64
* centos/7
* centos/6
* debian/jessie64
* debian/wheezy64

### Chef
- Chef '>= 12.5'

### Cookbooks
- apt

## Attributes
* `node['redis']['port'] => '6379'` This is the port Redis Server will listen on.
Port `6379` is the standard port for Redis Server.
* `node['redis']['bind'] => '127.0.0.1'` This is the interface Redis Server will
bind to. Use `0.0.0.0` to bind to all interfaces.
* `node['redis']['maxmemory'] => '1gb'` This is the maximum amount of memory Redis
Server will use. The size is case insensitive.

## Usage
Here's an example `redis` role that will install Redis. This example changes the
memory limit to 4GB.

```ruby
name 'redis'
description 'install redis'

override_attributes(
    'redis' => {
        'maxmemory' => '4GB'
    }
)

run_list(
    'recipe[cop_redis::default]'
)
```

## Testing
* http://kitchen.ci
* http://serverspec.org

Testing is handled with ServerSpec, via Test Kitchen, which uses Docker to spin up VMs.

ServerSpec and Test Kitchen are bundled in the ChefDK package.

### Dependencies
```bash
$ brew cask install chefdk
$ chef gem install kitchen-docker
$ brew install docker docker-machine
$ docker-machine create default --driver virtualbox
```

### Running
Get a listing of your instances with:

```bash
$ kitchen list
```

Run Chef on an instance, in this case default-ubuntu-1204, with:

```bash
$ kitchen converge default-ubuntu-1204
```

Destroy all instances with:

```bash
$ kitchen destroy
```

Run through and test all the instances in serial by running:

```bash
$ kitchen test
```

## Notes
* The `Berksfile.lock` file has been purposely omitted, as we don't care about upstream dependencies.
