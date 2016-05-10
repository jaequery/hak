# Hak

## What does it do

Hak strives to create the most optimal development environment using Docker for Mac OSX.
It comes with built-in DNS and NFS mounting capabilities for managing your websites much easier.
Bonus: It also comes with built-in web framework called "Honeybadger" for you to start creating websites right away.

## Getting Started

#### Pre-requisites

* Mac OSX "Yosemite or El Capitan"

#### Install

```sh
$ gem install hak
```

#### Power on

This is all it takes to get started, very simple.

```sh
hak on
```

The first time it runs, it will try install everything including Docker Machine, Dnsmasq, and an NFS daemon.

After installed, you should also run this or add this to your bash profile:

```
eval $(dinghy env)
```

#### Create a site

Now go into a folder where you'd like to store all your websites, for instance: ~/Sites.

```sh
hak create somesite
```

This will have created somsite in your current working directory.

#### Start site

```sh
cd somesite
hak up
```

Once done, your site should now be viewable at: http://somesite.docker/


#### Virtual Hosts
Hakberry automatically proivdes you a jwilder/proxy and dnsmasq. This allows you to set a VIRTUAL_HOST property in your docker-compose.yml file which will allow you to perform virtual hosting on multiple domains.

For example, if you place this inside your docker-compose.yml, notice the VIRTUAL_HOST:

```
app:
 image: jaequery/honeybadger
 links:
 - db:honeybadger-postgres
 command: /app/bin/docker/init.sh
 environment:
 - VIRTUAL_HOST=somesite.docker
 - RACK_ENV=development
 - BUNDLE_PATH=/app/volumes/bundler
 volumes:
 - .:/app
```

This will allow you to view your website at http://somesite.docker/
