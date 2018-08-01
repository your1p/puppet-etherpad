class etherpad::plugins::ep_button_link {
  include etherpad::plugins::common

  concat::fragment{'ep_bouton_link':
    target  => "${etherpad::root_dir}/settings.json",
    content => epp('etherpad/plugins/ep_button_link.epp'),
    }
}
