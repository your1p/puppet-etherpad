class etherpad::plugins::ep_button_link {
  etherpad::plugins::common { 'ep_button_link' :
  }
  $default_button_link_options = {
    text    => 'Hello world',
    link    => 'http://whatever.com',
    classes => 'grouped-left',
    before  => "li[data-key='showTimeSlider']",
    after   => "li[data-key='showTimeSlider']",
  }
  $_real_button_link_options = merge($default_button_link_options, $etherpad::button_link)
  concat::fragment { "ep_button_link":
    target  => "${::etherpad::root_dir}/settings.json",
    content => epp("${module_name}/plugins/ep_button_link.epp"),
    order   => '11',
  }
}
