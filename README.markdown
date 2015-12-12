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
  ensure => 'present',
  db_provider => 'mysql',
  db          => 'etherpad',
  user        => 'etherpad',
  password    => '37h3rp4d',
}
```

## Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
