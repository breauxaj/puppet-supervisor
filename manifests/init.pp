class supervisor (
  $ensure = 'latest',
) {
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'supervisor' ],
  }

  $context = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ '/files/etc/supervisord.conf' ],
  }

  $include = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ '/etc/supervisor.d' ],
  }

  package { $required: ensure => $ensure }

  augeas { "supervisord_include":
    context => "${context}/include",
    onlyif  => "get files != '${include}'",
    changes => "set files '${include}'",
    require => Package[$required],
    incl    => "${context}",
    lens    => 'IniFile.lns',
  }

}
