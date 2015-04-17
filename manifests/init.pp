class supervisor (
  $ensure = 'latest',
) {
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'supervisor' ],
  }

  $config = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ '/etc/supervisord.conf' ],
  }

  package { $required: ensure => $ensure }

  file { '/etc/supervisor.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  file { "${config}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('supervisor/supervisord.erb'),
    require => Package[$required],
  }

}
