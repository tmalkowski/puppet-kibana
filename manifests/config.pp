#
class kibana::config {
  vcsrepo { $kibana::install_dir:
    ensure   => latest,
    provider => 'git',
    source   => 'git://github.com/rashidkpc/Kibana.git',
    revision => 'kibana-ruby',
    require  => Class['git'],
  }

  apache::vhost { $::fqdn:
    port     => '80',
    docroot  => '/srv/www/kibana/public',
    options  => [ '-Indexes', '-MultiViews' ],
    override => [ 'None' ],
  }
  if $kibana::rvm == true {
    class { 'rvm::passenger::apache':
      version      => '4.0.2',
      ruby_version => 'ruby-2.0.0-p0-dev',
      mininstances => '3',
      maxpoolsize  => '30',
    }
  } else {
    include apache::mod::passenger
  }
}

if defined(Class['kibana']) {
  Class['kibana::config'] ~> Service['httpd']
}

# vim: ts=2 sw=2 et ft=puppet:
