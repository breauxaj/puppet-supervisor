define supervisor::config (

) {
  include ::supervisor

  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'supervisord',
  }

  file { '/etc/sysconfig/supervisor':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('supervisor/sysconfig.erb'),
    notify  => Service[$service],
  }

  file { '/etc/profile.d/supervisor.sh':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('supervisor/profile.erb'),
    notify  => Service[$service],
  }

}
