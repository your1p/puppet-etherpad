# Matches Pad Options Keys And Values
type Etherpad::Plugins = Struct[
  {
    Optional['ep_button_link'] => Boolean,
    Optional['ep_stats']       => Boolean,
    Optional['ep_ldapauth']    => Boolean,
  }
]
