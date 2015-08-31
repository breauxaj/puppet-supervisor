define supervisor::config (
  $value
) {
  include ::supervisor

  $key = $title

  $context = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/files/etc/supervisord.conf',
  }

  augeas { "supervisord_conf/${key}":
    context => $context,
    onlyif  => "get ${key} != '${value}'",
    changes => "set ${key} '${value}'",
  }

}
