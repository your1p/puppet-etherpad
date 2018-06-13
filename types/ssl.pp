# Matches parameters
type Etherpad::Ssl = Struct[
  {
    Optional['key']  => Variant[Stdlib::Absolutepath],
    Optional['cert'] => Variant[Stdlib::Absolutepath],
  }
]
