class supervisor (
  $ensure = 'latest',
) {
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'supervisor' ],
  }

  $config = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ '/etc/supervisord.conf' ],
  }

  package { $required:
    ensure   => $ensure,
    provider => 'pip'
  }

  file { '/etc/supervisor.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  exec { 'echo_supervisord_conf':
    path    => '/bin:/usr/bin',
    command => "/usr/bin/echo_supervisord_conf >> ${config}",
    creates => "${config}",
    onlyif  => "test ! -f ${config}",
  }

}
