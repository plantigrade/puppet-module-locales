class locales {

  # Compatibility check
  $compatible = [ 'CentOS', 'Debian', 'Ubuntu' ]
  if ! ($::operatingsystem in $compatible) {
    fail("Module is not compatible with ${::operatingsystem}")
  }

  case $::operatingsystem {
      /^Debian./ : { include puppet-module-locales::locales-debian }
      /^Ubuntu./ : { include puppet-module-locales::locales-debian }
      /^Centos./ : { include puppet-module-locales::locales-centos }
  }

}

