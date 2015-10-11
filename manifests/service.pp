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

  case $::osfamily {
    'redhat': {
      case $::lsbmajdistrelease {
        '6': {
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
        default: {
          include ::systemctl

          service { $service:
            ensure  => $ensure,
            enable  => $enable,
            require => File['/lib/systemd/system/supervisord.service']
          }

          file { '/lib/systemd/system/supervisord.service':
            ensure => present,
            owner  => 'root',
            group  => 'root',
            mode   => '0755',
            source => 'puppet:///modules/supervisor/supervisord.service'
          }

          file { '/etc/systemd/system/supervisord.service':
            ensure  => 'link',
            owner   => 'root',
            group   => 'root',
            target  => '/lib/systemd/system/supervisord.service'
          } ~>
          Exec['systemctl-daemon-reload']
        }
      }
    }
    default: {
      notify { 'OS not supported by this module': }
    }
  }

}