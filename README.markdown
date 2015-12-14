#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with etherpad](#setup)
    * [What etherpad affects](#what-etherpad-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with etherpad](#beginning-with-etherpad)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and configures etherpad(-lite).
It's inspired by existing etherpad modules on the Forge, but attempts to "*do it right™*".


## Setup

### What etherpad affects

* This module depends on [puppet-nodejs](https://forge.puppetlabs.com/puppet/nodejs)
* It also depends on [puppetlabs-vcsrepo](https://forge.puppetlabs.com/puppetlabs/vcsrepo), and hence git
* It will setup a service using the system's preferred init

### Setup Requirements

This module requires a database. With no database available, it will use the fallback dirtydb.
dirtydb is not intended for production use.

For a migration from DirtyDB, please consult [this blog
post](https://codeborne.com/2011/10/19/etherpad-lite-migrate-data-from-dirtydb.html)

### Beginning with etherpad

Before to installation, a target database should exist. Please consult the
documentation of
[puppetlabs-postgresql](https://forge.puppetlabs.com/puppetlabs/postgresql), or
[puppetlabs-mysql](https://forge.puppetlabs.com/puppetlabs/mysql) for how to
create those.

## Usage

The basic usage is:

```puppet
include ::etherpad
```

note that this will use the local DirtyDB and is not recommended beyond basic testing.
For production setups, use:

```puppet
class { ::etherpad:
  ensure            => 'present',
  database_provider => 'mysql',
  database_name     => 'etherpad',
  database_user     => 'etherpad',
  database_password => '37h3rp4d',
}
```

## Reference

### etherpad

The etherpad module installs and configures etherpad.  This class is the entry
point for the module and the configuration point.

#### ensure

Ensure the presence (`present`, `latest`) or absence (`absent`) of etherpad.
This can also be set to a specific version (or SHA1 hash). By default, we
install from the branch `develop`, in order to cater for newer versions of
Nodejs. `absent` will completely remove the software, its dependencies, and the
users and groups.

|Type|Default|
|----|-------|
| String | `present` |

#### service_name

Name under which the service will be known.

|Type |Default |
|-----|--------|
| String | `etherpad` |

#### service_ensure

Ensure whether the service is running or stopped. If you're passing `absent` to
`ensure`, please also pass `stopped` to `service_ensure`.

|Type |Default |
|-----|--------|
| Enum['running', 'stopped'] | `running` |


#### service_provider

Which [service provider](https://docs.puppetlabs.com/references/latest/type.html#service-providers)
to use. By default this is taken from stdlib's [`$::service_provider`]() fact.
Currently only `upstart` and `systemd` are supported!

|Type |Default |
|-----|--------|
| Optional[String] | `$::service_provider` |


#### manage_user

Whether to manage the user & group under which etherpad will be running.

|Type |Default |
|-----|--------|
|Boolean|`true`|

#### manage_abiword

Whether to manage the dependency of the abiword package.

|Type |Default |
|-----|--------|
|Boolean|`false`|

#### abiword__path

Absolute Path to the abiword binary.

|Type |Default |
|-----|--------|
|String|'/usr/bin/abiword'|

#### manage_tidy

Whether to manage the dependency of the tidy package.

|Type |Default |
|-----|--------|
|Boolean|`false`|

#### abiword__path

Absolute Path to the abiword binary.

|Type |Default |
|-----|--------|
|String|'/usr/bin/abiword'|

#### user & group

The user and group under which etherpad will be running.

|Type |Default |
|-----|--------|
|String|'etherpad'|

#### root_dir

Absolute Path of the etherpad installation.

|Type |Default |
|-----|--------|
|String|'/opt/etherpad'|


#### source

URL to the git source of etherpad.

|Type |Default |
|-----|--------|
|String|'https://github.com/ether/etherpad-lite.git'|

  String  $database_type     = 'dirty',
  String  $database_host     = 'localhost',
  String  $database_user     = 'etherpad',
  String  $database_name     = 'etherpad',
  String  $database_password = 'etherpad',

  # Network
  Optional[String] $ip          = undef,
  Integer          $port        = 9001,
  Optional[String] $trust_proxy = undef,

  # Performance
  Integer $max_age = 21600,
  Boolean $minify  = true,

  # Config
  Boolean $require_session        = false,
  Boolean $edit_only              = false,
  Boolean $require_authentication = false,
  Boolean $require_authorization  = false,
  Optional[String]  $pad_title    = undef,
  String  $default_pad_text       = 'Welcome to etherpad!',
  String  $session_key            = fqdn_rand_string(30),

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
