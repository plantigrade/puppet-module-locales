class locales {

  # Compatibility check
  $compatible = [ 'CentOS', 'Debian', 'Ubuntu' ]
  if ! ($::operatingsystem in $compatible) {
    fail("Module is not compatible with ${::operatingsystem}")
  }

  case $::operatingsystem {
      /^Debian./ : { include locales::dist::debian }
      /^Ubuntu./ : { include locales::dist::debian }
      /^Centos./ : { include locales::dist::centos }
  }

}

