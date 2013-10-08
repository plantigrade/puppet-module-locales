class locales::dist::centos {

  $default = $::locale_default ? {
    ''      => 'en_US.UTF-8',
    default => $::locale_default
  }

  $available = $::locale_available ? {
    ''      => ['en_US.utf8 UTF-8', 'fr_FR.utf8 UTF-8'],
    default => $::locale_available
  }

  package { 'glibc-common':
    ensure => present,
  }

  file { '/etc/sysconfig/i18n':
    content => template('locales/centos-etc-sysconfig-i18n.erb'),
    require => Package['glibc-common'],
  }

  define locale_add {

    $current_input   = regsubst($name, '\..*$', '')
    $current_charmap = regsubst($name, '^.*\s', '')
    $current_output  = regsubst($name, '\s.*$', '')

    exec { "localedef_$current_output":
      command => "localdef -i $current_input -f $current_charmap $current_output",
      onlyif  => "! locale -a | grep $current_output",
      notify  => Exec['build-locale-archive'],
    }

  }

  locale_add { $available }

  exec { 'build-locale-archive':
    refreshonly => true,
    require => Package['glibc-common'],
  }

