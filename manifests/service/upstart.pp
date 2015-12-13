# create service definition for etherpad for upstart
class etherpad::seervice::upstart {
  case $::etherpad::ensure {
    'absent': {
      $file_ensure = 'absent'
      $link_ensure = 'absent'
    }
    default: {
      $file_ensure = 'link'
      $link_ensure = 'link'
    }
  }

  file { '/etc/init/etherpad.conf':
    ensure  => $file_ensure,
    content => epp("${module_name}/service/upstart.epp"),
  }

  file { '/etc/init.d/etherpad':
    ensure => $link_ensure,
    target => '/lib/init/upstart-job',
  }
}
