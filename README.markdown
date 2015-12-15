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

#### abiword_path

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

#### database_type

The type of database that etherpad should use. In case of `mysql` or `postgres`, you'll also have to set the options below.

|Type |Default |
|-----|--------|
|Enum['dirty', 'mysql', 'sqlite', 'postgres']|'dirty'|

#### database_host

Host on which the database is running.

|Type |Default |
|-----|--------|
|String|`localhost`|

#### database_user

User (or role) to use, when connecting to the database.
 
|Type |Default |
|-----|--------|
|String|`etherpad`|

#### database_name

Name of database to connect to.
 
|Type |Default |
|-----|--------|
|String|`etherpad`|


#### database_password

Password to use when connecting to database.
 
|Type |Default |
|-----|--------|
|String|`etherpad`|


#### ip

IP on which etherpad will be listening. The default, `undef`, turns into
`null`, and hence NodeJS' default of "all interfaces".

|Type |Default |
|-----|--------|
|String|`undef`|

#### port

Port on which etherpad will be listening.

|Type |Default |
|-----|--------|
|Integer|`9001`|

#### trust_proxy

This value should be set if etherpad is running behind a proxy.

|Type |Default |
|-----|--------|
|Boolean|`false`|

#### max_age

How long clients may use served JavaScript code (in seconds).

|Type |Default |
|-----|--------|
|Integer|21600|

#### minify

Whether to minify the delivered JavaScript and CSS.


|Type |Default |
|-----|--------|
|Boolean|`true`|


#### require_session

Users must have a session to access pads. This effectively allows
only group pads to be accessed.

|Type |Default |
|-----|--------|
|Boolean|`false`|

#### edit_only

Users may edit pads but not create new ones. Pad creation is only
via the API. This applies both to group pads and regular pads.

|Type |Default |
|-----|--------|
|Boolean|`false`|

#### require_authentication

This setting is used if you require authentication of all users.

Note: `/admin` always requires authentication.

|Type |Default |
|-----|--------|
|Boolean|`false`|

#### require_authorization

Require authorization by a module, or a user with is_admin set,
see below.

|Type |Default |
|-----|--------|
|Boolean|`false`|

#### pad_title

Name of your instance

|Type |Default |
|-----|--------|
|Optional[String]|`undef`|

#### default_pad_text

The default text of a pad.

|Type |Default |
|-----|--------|
|String|`Welcome to etherpad!`|


## Limitations

Currently, only upstart and systemd are supported as Service
providers. More support is highly welcomed.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
