define supervisor::hook (
  $command,
  $autostart,
  $autorestart,
  $environment, 
  $stderr_logfile,
  $stdout_logfile,
  $user
) {
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'supervisor' ],
  }

  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'supervisord' ],
  }

  $config = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ '/etc/supervisor/conf.d' ],
  }

  $hook = $title
  
  file { "${config}/${hook}.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('supervisor/hook.erb'),
    notify  => Service[$service],
    require => Package[$required],
  }

}
