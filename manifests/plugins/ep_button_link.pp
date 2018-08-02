class etherpad::plugins::ep_button_link {
  $default_button_link_options = {
    text    => 'Hello world',
    link    => 'http://whatever.com',
    classes => 'grouped-left',
    before  => "li[data-key='showTimeSlider']",
    after   => "li[data-key='showTimeSlider']",
  }
  etherpad::plugins::common { 'ep_button_link' :
    plugin_name => 'ep_button_link',
  }
  concat::fragment { "ep_button_link":
    target  => "${::etherpad::root_dir}/settings.json",
    content => "${etherpad::root_dir}/node_modules/",
    order   => '02',
  }
}
