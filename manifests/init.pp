# Class: etherpad
# ===============
#
# The etherpad module installs and configures etherpad.
# This class is the entry point for the module and the configuration point.
#
class etherpad (
  # General
  String  $ensure         = 'present', # This should be a pattern, but right now that's too long
  String  $service_name   = 'etherpad',
  String  $service_ensure = 'running', # again, should be an enum…
  Boolean $manage_user    = true,
  Boolean $manage_abiword = true,
  String  $abiword_path   = '/usr/bin/abiword',
  String  $user           = 'etherpad',
  String  $group          = 'etherpad',
  String  $root_dir       = '/opt/etherpad',
  String  $source         = 'https://github.com/ether/etherpad-lite.git',

  # Db
  String  $database_type     = 'dirty',
  String  $database_host     = 'localhost',
  String  $database_user     = 'etherpad',
  String  $database_name     = 'etherpad',
  String  $database_password = 'etherpad',

  # Network
  String           $ip          = '*',
  String           $port        = '9001',
  Optional[String] $trust_proxy = undef,

  # Performance
  Integer $max_age = 21600,
  Boolean $minify  = true,

  # Config
  Boolean $edit_only              = false,
  Boolean $require_authentication = false,
  Boolean $require_authorization  = false,
  Optional[String]  $comment      = undef,
  String  $default_pad_text       = 'Welcome to etherpad!',
  String  $session_key            = fqdn_rand_string(30),
) {

  validate_absolute_path($abiword_path)
  validate_absolute_path($root_dir)

  unless $ensure =~
    Variant[Enum['present', 'latest', 'absent'], Pattern[/\A\d\.\d\.\d\Z/, /\A[a-fA-F0-9]{6,40}\Z/]] {
    fail("ensure must be either 'present', 'absent', 'latest', a version number, or a git SHA1 sum")
  }
  unless $service_ensure =~ Enum['running', 'stopped'] {
    fail("service_ensure must be either 'running', or 'stopped'")
  }
  unless $database_type =~ Enum['dirty', 'mysql', 'sqlite', 'postgres'] {
    fail("database_type must be either 'dirty', 'mysql', 'sqlite', or 'postgres'")
  }

  if $manage_user {
    contain '::etherpad::user'

    Class['etherpad::user'] ->
    Class['etherpad::install']
  }

  contain '::etherpad::install'
  contain '::etherpad::config'
  contain '::etherpad::service'

  Class['etherpad::install'] ->
  Class['etherpad::config'] ~>
  Class['etherpad::service']

  Class['etherpadd::install'] ~>
  Class['etherpadd::service']
}
