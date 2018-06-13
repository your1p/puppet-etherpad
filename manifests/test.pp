$value2 = {
  'key1' => 'value',
}


$mytest = {
            'key1' => 'value1',
            'key2' => "$value2",
}

file { '/tmp/myhash.json' :
  ensure  => file,
  content => to_json_pretty($myhash),
}

notice "to_pretty_json : $myhash")
