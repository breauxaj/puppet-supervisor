define supervisor::service (
  $ensure,
  $enable
) {
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'supervisor' ],
  }

  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'supervisord',
  }

  service { $service:
    ensure  => $ensure,
    enable  => $enable,
    require => Package[$required],
  }

}
