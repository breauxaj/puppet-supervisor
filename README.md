supervisor
----------

Supervisor is a client/server system that allows its users to control a number
of processes on UNIX-like operating systems.

http://supervisord.org/

Samples
-------
```
include supervisor
```
```
supervisor::config {
  "supervisord/http_port":        value => '/var/tmp/supervisor.sock';
  "supervisord/logfile":          value => '/var/log/supervisor/supervisord.log';
  "supervisord/logfile_maxbytes": value => '50MB';
  "supervisord/logfile_backups":  value => '10';
  "supervisord/loglevel":         value => 'info';
  "supervisord/pidfile":          value => '/var/run/supervisord.pid'
  "supervisord/nodaemon":         value => 'false';
  "supervisord/minfds":           value => '1024';
  "supervisord/minprocs":         value => '200';
  "supervisorctl/serverurl":      value => 'unix:///var/tmp/supervisor.sock';
  "include/files":                value => '/etc/supervisor.d/*.conf';
}
```

License
-------
GPL3

Contact
-------
breauxaj AT gmail DOT com
