class etherpad::plugins::ep_ldapauth {
  etherpad::plugins::common { 'ep_ldapauth' :
  }
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
  $_real_ldapauth_options = merge($default_ldapauth_options, $etherpad::ldapauth)
  concat::fragment { "ep_ldapauth":
    target  => "${::etherpad::root_dir}/settings.json",
    content => epp("${module_name}/plugins/ep_ldapauth.epp"),
    order   => '12',
  }
}
