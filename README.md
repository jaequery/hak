# Hak

## What does it do


## Getting Started

#### Pre-requisites

* Mac OSX "Yosemite or El Capitan"

#### Download hak

```sh
$ sudo gem install hak
```

#### Install Hak

```sh
hak install
```

This will try install everything including Docker, Docker Machine, Docker Compose, Dnsmasq, Nginx Proxy, and an NFS daemon.
After installed, you should also run this and add this to your ~/.bash_profile (or ~/.zshrc):

```
eval $(dinghy env)
```

Now power it on by typing

```
hak on
```

To verify that it is all working, just type:

```
hak ps
```

You should see proxy is up and running, which is the jwilder nginx proxy hak automatically uses for virtual hosting all your websites.

#### Create a site

Now go into a folder where you'd like to store all your websites, for instance: ~/Sites.

```sh
hak create somesite
```

This will have created somesite in your current working directory.

#### Start site

```sh
cd somesite
hak up
```

Once done, your site should now be viewable at http://somesite.docker/ from your browser (don't forget the trailing slash).

## How does it all work?

Hak currently uses Dinghy as a boilerplate to setup many of the things required for an optimal Docker environment on OSX.
It is virtually a one-click setup and even comes with batteries included via Dinghy:

- Docker 
- Docker Machine
- xhyve
- Nginx HTTP Proxy
- DNS
- NFS

Bonus: It also comes with built-in web framework called "Honeybadger" for you to start creating websites right away.

### Dinghy
Dinghy installs a DNS server listening on the private interface, which
resolves \*.docker to the Dinghy VM. For instance, if you have a running
container that exposes port 3000 to the host, and you like to call it
`myrailsapp`, you can connect to it at `myrailsapp.docker` port 3000, e.g.
`http://myrailsapp.docker:3000/` or `telnet myrailsapp.docker 3000`.

### HTTP proxy

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

## FAQ

### It didn't install correctly? Run this:

```
sudo chown -R $(whoami) /usr/local
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

That should fix any brew related issues you might be having.

### Docker command doesn't work? Run this:

```
echo 'eval $(dinghy env)' >> ~/.bashrc
```
