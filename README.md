# Hak

## What does it do

Hak is a CLI that provides you with a robust, optimal development environment utilizing Docker for your Mac OSX.
It is virtually a one-click setup and even comes with batteries included via Dinghy:
- Docker 
- Docker Machine
- xhyve
- DNS
- NFS

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

#### DNS

Dinghy installs a DNS server listening on the private interface, which
resolves \*.docker to the Dinghy VM. For instance, if you have a running
container that exposes port 3000 to the host, and you like to call it
`myrailsapp`, you can connect to it at `myrailsapp.docker` port 3000, e.g.
`http://myrailsapp.docker:3000/` or `telnet myrailsapp.docker 3000`.

#### HTTP proxy

Dinghy will run a HTTP proxy inside a docker container in the VM, giving you
easy access to web apps running in other containers. This is based heavily on
the excellent [nginx-proxy](https://github.com/jwilder/nginx-proxy) docker tool.

The proxy will take a few moments to download the first time you launch the VM.

Any containers that you want proxied, make sure the `VIRTUAL_HOST`
environment variable is set, either with the `-e` option to docker or
the environment hash in docker-compose. For instance setting
`VIRTUAL_HOST=myrailsapp.docker` will make the container's exposed port
available at `http://myrailsapp.docker/`. If the container exposes more
than one port, set `VIRTUAL_PORT` to the http port number, as well.

See the nginx-proxy documentation for further details.

If you use docker-compose, you can add VIRTUAL_HOST to the environment hash in
`docker-compose.yml`, for instance:

```yaml
web:
  build: .
  environment:
    VIRTUAL_HOST: myrailsapp.docker
```

