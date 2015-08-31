define supervisor::service (
  $ensure,
  $enable
) {
  include ::supervisor

  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'supervisor' ],
  }

  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'supervisord',
  }

  service { $service:
    ensure  => $ensure,
    enable  => $enable,
    require => [
      File['/etc/init.d/supervisord'],
      Package[$required]
    ]
  }

  file { '/etc/init.d/supervisord':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/supervisor/supervisord.init'
  }

}
