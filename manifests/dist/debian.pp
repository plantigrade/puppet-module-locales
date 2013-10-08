class locales-debian {

  $default = $::locale_default ? {
    ''      => 'en_US.UTF-8',
    default => $::locale_default
  }

  $available = $::locale_available ? {
    ""      => ['en_US.UTF-8 UTF-8', 'fr_FR.UTF-8 UTF-8'],
    default => $::locale_available
  }

  package { 'locales':
    ensure => present,
  }

  file { '/etc/locale.gen':
    content => template('locales/debian-etc-locale.gen.erb'),
  }

  file { '/etc/default/locale':
    content => template('locales/debian-etc-default-locale.erb'),
  }

  exec { 'locale-gen':
    subscribe   => [File['/etc/locale.gen'], File['/etc/default/locale']],
    refreshonly => true,
  }

  exec { 'update-locale':
    subscribe   => [File['/etc/locale.gen'], File['/etc/default/locale']],
    refreshonly => true,
  }

  Package[locales] -> File['/etc/locale.gen']
                   -> File['/etc/default/locale']
                   -> Exec['locale-gen']
                   -> Exec['update-locale']
}
