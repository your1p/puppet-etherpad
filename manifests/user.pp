# == Class etherpad::user
#
# This class is called from etherpad for creating the user.
#
class etherpad::user {

  # ensure correct ordering in case of deinstallation

  if $::etherpad::ensure == 'absent' {
    $user_ensure   = $::etherpad::ensure
    $user_require  = undef
    $group_require = User[$::etherpad::user]
  } else {
    $user_ensure   = 'present'
    $user_require  = Group[$::etherpad::group]
    $group_require = undef
  }

  group { $::etherpad::group:
    ensure  => $user_ensure,
    system  => true,
    require => $group_require,
  }
  user { $::etherpad::user:
    ensure  => $user_ensure,
    gid     => $::etherpad::group,
    home    => $::etherpad::root_dir,
    system  => true,
    require => $user_require,
  }

}
