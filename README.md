Simple tool to gather your running servers activities

## Installing

    git clone git@github.com:installero/spire_monitor.git
    cd spire_monitor

## Running daemon

    gem install sys-proctable
    ruby daemon.rb start

## Running server

    gem install mongrel-soap4r
    ruby server.rb

## Running client

    gem install soap4r
    ruby client.rb


## Configuring

Processes names that you want to monitor are hardcoded in spire_monitor.rb file, so edit it if you want to monitor other servers that nginx or mongrel.
