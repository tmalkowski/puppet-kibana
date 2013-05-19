class kibana::install {
  # TODO: parameterize this
  $dir = '/srv/www/kibana'

  # TODO: modulefile requires puppetlabs-ruby
  #class { 'ruby':
  #  version         => 'latest',
  #  gems_version    => 'latest',
  #  rubygems_update => false,
  #}
  include rvm
  rvm_system_ruby { 'ruby-2.0.0-p0': ensure => present, default_use => true;
                    'ruby-2.0.0-p0-dev': ensure => present, }
  rvm_gem { 'bundler':
    ensure       => present,
    ruby_version => 'ruby-2.0.0-p0',
    require      => Rvm_system_ruby['ruby-2.0.0-p0'],
  }
  rvm::system_user { 'jbartko': }

  # TODO: modulefile requires puppetlabs-git
  include git

  # TODO: modulefile requires vcsrepo
  vcsrepo { $dir:
    ensure   => present,
    provider => 'git',
    source   => 'git://github.com/rashidkpc/Kibana.git',
    revision => 'kibana-ruby',
    require  => Class['git'],
  }

  exec { 'bundler':
    command => 'bundle install',
    path    => $::path,
    cwd     => $dir,
    unless  => 'bundle check',
    require => [ Vcsrepo[$dir], Rvm_gem['bundler'] ],
  }

  class { 'apache': default_vhost => false, }

  # TODO: modulefile requires blt04-rvm
  class { 'rvm::passenger::apache':
    version      => '4.0.2',
    ruby_version => 'ruby-2.0.0-p0',
    mininstances => '3',
    maxpoolsize  => '30',
  }
}

# vim: set ts=2 sw=2 et ft=puppet:
