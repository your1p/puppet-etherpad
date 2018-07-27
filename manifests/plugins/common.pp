class etherpad::plugins::common {
  package { "${_pname}" :
    ensure   => installed,
    provider => 'npm',
  }
