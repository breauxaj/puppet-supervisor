define supervisor::sysconfig (
  $value
) {
  include ::supervisor

  $key = $title

  $context = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/files/etc/sysconfig/supervisord',
  }

  augeas { "sysconfig_supervisord/${key}":
    context => $context,
    onlyif  => "get ${key} != '${value}'",
    changes => "set ${key} '${value}'",
    require => File['/etc/sysconfig/supervisord']
  }

  file { '/etc/sysconfig/supervisord' :
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

}
