class etherpad::plugins::ep_mypads {
  etherpad::plugins::common { 'ep_mypads' :
  }
  $default_mypads_options = {
    url                    => $etherpad::plugins::ep_ldapauth::_real_ldapauth_options[url],
    bindDN                 => $etherpad::plugins::ep_ldapauth::_real_ldapauth_options[searchDN],
    bindCredentials        => $etherpad::plugins::ep_ldapauth::_real_ldapauth_options[searchPWD],
    searchBase             => $etherpad::plugins::ep_ldapauth::_real_ldapauth_options[groupSearchBase],
    searchFilter           => $etherpad::plugins::ep_ldapauth::_real_ldapauth_options[searchFilter],
    tlsOptions             => {
        rejectUnauthorized => false
    },
    properties    =>  {
        login     => "uid",
        email     => "mail",
        firstname => "givenName",
        lastname  => "sn"
    },
    users        => {
      admin      => {
        password => 'changeme1',
        is_admin => true
      }
    },
    defaultLang => "fr"
  }

  nodejs::npm { ldapauth-fork :
    ensure => 'present',
    target => "${etherpad::root_dir}/"
  }

  $_real_mypads_options = merge($default_mypads_options, $etherpad::mypads)
  concat::fragment { 'ep_mypads':
    target  => "${::etherpad::root_dir}/settings.json",
    content => epp("${module_name}/plugins/ep_mypads.epp"),
    order   => '12',
  }
}
