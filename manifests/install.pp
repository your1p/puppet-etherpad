# == Class etherpad::install
#
# This class is called from etherpad for install.
#
class etherpad::install {


  case $::etherpad::ensure {
    'present', 'absent', 'latest': {
      $abiword_ensure = $::etherpad::ensure
      $vcs_ensure     = $::etherpad::ensure
      $vcs_revision   = 'master'
    }
    default: {
      $abiword_ensure = 'present'
      $vcs_ensure     = 'present'
      $vcs_revision   = $::etherpad::ensure
    }
  }

  if $manage_abiword {
    package { 'abiword':
      ensure => $abiword_ensure,
  }

  vcsrepo { $::etherpad::root_dir:
    ensure   => $vcs_ensure,
    owner    => $::etherpad::user,
    group    => $::etherpad::group,
    revision => $vcs_revision,
  }

}
