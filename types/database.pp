#Matches database
type Etherpad::Database = Struct[
  {
    Optional['filename'] => Variant[Stdlib::Abslolutepath],
    Optional['user']     => String[1],
    Optional['host']     => String[1],
    Optional['password'] => String[1],
    Optional['database'] => String[1],
  }
]
