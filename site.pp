node default {
  class { 'ntp':
  servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu']
  }
}

class { '::mysql::server':
    root_password    => 'Epam_2011',
    override_options => {
      'mysqld' => { 'max_connections' => '1024' }
    },
  }
  mysql_database { 'test_mdb':
      ensure  => present,
      charset => 'utf8',
  }
  mysql_user { 'test_user@localhost':
    ensure => present,
  }
  mysql_grant { 'test_user@localhost/test_mdb.*':
    ensure      => present,
    options     => ['GRANT'],
    privileges  => ['ALL'],
    table       => 'test_mdb.*',
    user        => 'test_user@localhost',
  }

