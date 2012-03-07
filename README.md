Purpose
=======

Collect all of the puppet stats from syslog and inject them into graphite

Installing
==========

Run: 

    gem install


Setting up
==========

edit the config file

    vim config/environment.rb


Setting up Rsyslog
==================

add lines similar to the following to your rsyslog.conf

  if $programname == 'puppet-agent' then @MY_GRAPHITE_MACHINE:2515
  if $programname == 'puppet-master' then @MY_GRAPHITE_MACHINE:2515

