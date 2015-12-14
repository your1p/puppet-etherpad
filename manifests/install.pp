# == Class etherpad::install
#
# This class is called from etherpad for install.
#
class etherpad::install {

  case $::etherpad::ensure {
    'present', 'absent', 'latest': {
      $deps_ensure    = $::etherpad::ensure
      $vcs_ensure     = $::etherpad::ensure
      $vcs_revision   = 'develop' # master doesn't currently "work" with node 4, 5
    }
    default: {
      $deps_ensure    = 'present'
      $vcs_ensure     = 'present'
      $vcs_revision   = $::etherpad::ensure
    }
  }

  if $::etherpad::manage_abiword {
    package { 'abiword':
      ensure => $deps_ensure,
    }
  }
  if $::etherpad::manage_tidy {
    package { 'tidy':
      ensure => $deps_ensure,
    }
  }

  vcsrepo { $::etherpad::root_dir:
    ensure   => $vcs_ensure,
    provider => 'git',
    owner    => $::etherpad::user,
    group    => $::etherpad::group,
    source   => $::etherpad::source,
    revision => $vcs_revision,
  }

}
