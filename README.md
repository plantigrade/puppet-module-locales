Puppet Locales Module
=====================

Module for configuring locales.

Installation
------------

Clone this repo to a locales directory under your Puppet modules directory:

    git clone git://github.com/uggedal/puppet-module-locales.git locales

If you don't have a Puppet Master you can create a manifest file
based on the notes below and run Puppet in stand-alone mode
providing the module directory you cloned this repo to:

    puppet apply --modulepath=modules test_locales.pp


