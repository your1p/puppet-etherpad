class etherpad::plugins::ep_ldapauth {
  include etherpad::plugins::common

  concat::fragment{'ep_ldapauth':
    target  => "${etherpad::root_dir}/settings.json",
    content => epp('etherpad/plugins/ep_ldapauth.epp'),
  }
}
