class supervisor (
  $ensure = 'latest',
) {
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'supervisor', 'distribute' ],
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

  file { "${config}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$required],
  }

}
