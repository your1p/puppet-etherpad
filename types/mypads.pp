# Matches Pad Options Keys And Values
type Etherpad::Mypads = Struct[
  {
    Optional['url']             => String,
    Optional['bindDN']          => String,
    Optional['bindCredentials'] => String,
    Optional['searchBase']      => String,
    Optional['searchFilter']    => String,
    Optional['tlsOptions']      => Boolean,
    Optional['properties']      => Hash[String, String],
    Optional['login']           => String,
    Optional['email']           => String,
    Optional['firstname']       => String,
    Optional['lastname']        => String,
    Optional['defaultLang']     => String,
    Optional['users']           => Hash[String, Variant[String, Boolean]],
  }
]
