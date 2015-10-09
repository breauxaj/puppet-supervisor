define supervisor::config (
  $value
) {
  include ::supervisor

  $key = $title

  $config = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/etc/supervisord.conf',
  }

  augeas { "supervisord_conf/${key}":
    lens    => 'Yum.lns',
    incl    => $config,
    onlyif  => "get ${key} != '${value}'",
    changes => "set ${key} '${value}'",
  }

}
