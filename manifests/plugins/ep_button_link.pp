class etherpad::plugins::ep_button_link {
Class["etherpad::plugins::common{$_pname :}"]
->$ep_button_link {
  'ep_button_link' => {
  'text'           => 'Hello World',
  'link'           => 'http://whatever.com',
  'classes'        => 'grouped-left',
  'before'         => "li[data-key='showTimeSlider']",
  'after'          => "li[data-key='showTimeSlider']",
  }
}
->concat::fragment{'ep_bouton_link':
  target  => "${etherpad::root_dir}/settings.json",
  content => "${ep_button_link}",
  owner   => 'etherpad',
  }
}
