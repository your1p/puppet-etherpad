class etherpad::plugins::ep_ldapauth {
  $default_ldapauth_options = {
    url                  => 'ldaps://ldap.example.com',
    accountBase          => 'ou=Users,dc=example,dc=com',
    accountPattern       => '(&(objectClass=*)(uid={{username}}))',
    displayNameAttribute => 'cn',
    searchDN             => 'uid=searchuser,dc=example,dc=com',
    searchPWD            => 'supersecretpassword',
    groupSearchBase      => 'ou=Groups,dc=example,dc=com',
    groupAttribute       => 'member',
    groupAttributeIsDN   => true,
    searchScope          => 'sub',
    groupSearch          => '(&(cn=admin)(objectClass=groupOfNames))',
    anonymousReadonly    => false,
  }
  etherpad::plugins::common { 'ep_ldapauth' :
    plugin_name => 'ep_ldapauth',
  }
  concat::fragment { "ep_ldapauth":
    target  => "${::etherpad::root_dir}/settings.json",
    content => "${etherpad::root_dir}/node_modules/",
    order   => '03',
  }
}
