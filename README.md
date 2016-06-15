# Hak

## What does it do

Hak is an all-in-one solution that downloads, runs, and deploy websites from your OSX.
It uses Docker so you can quickly run any kind of stacks at your disposal, such as node.js, Ruby, PHP, etc .
Hak also installs the most optimized Docker environment for you on your OSX through xhyve, nfs, and DNS/HTTP proxy out of the box.

Why use Hak? 

1) It allows you to run multiple apps at the same time and assigns a virtual host to each app it runs. No more http://localhost:3000/ now you can actually view them at http://yourappname.docker/

2) It runs off of standard docker-compose.yml file so no need to learn anything new. Hak doesn't add any complexity to Docker eco-system, it just simplifies it. For instance, hak start, is really just a shortcut to ```docker-compose up && docker-compose logs -f```

3) It lets you easily deploy your app to any Ubuntu server with standard SSH root/sudo access. No need to learn any complex deployment strategy, all you need to do is, type: ```hak deploy root@someserver.com``` and it will set up Docker and launches your app on the destination server. It is that simple!


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

These are public github repositories. Any repository with a docker-compose.yml and a VIRTUAL_HOST environmental variable in it should work. Hak will replace whatever is inside the VIRTUAL_HOST environment with the hostname you input when you type the hak get command.

[honeybadger](https://github.com/jaequery/honeybadger)
- a Ruby hackathon framework using Sinatra/Postgres with admin + ORM included
```
hak get jaequery/honeybadger mysite.com
```

[react-starter](https://github.com/jaequery/react-starter)
- an express + react + mongo
```
hak get jaequery/react-starter mysite.com
```

This will have created ./mysite.com/ directory and once you start it, you should be able to access your site from http://mysite.com.docker/

You can also edit the VIRTUAL_HOST manually by editing the docker-compose.yml file yourself.

#### Start the site

```sh
cd mysite.com
hak start
```

Your site should now be viewable at http://mysite.com.docker/ from your browser (don't forget the trailing slash).

Note) Once started, your prompt will attach itself to docker-compose logs -f, and you can hit Ctrl-c to escape out. 
To get back to the logs, you can type: ```hak logs```

And to stop:

```
hak stop
```

You can also restart it with:

```
hak restart
```

#### Deply your site

Once you are done developing your site, it is time to deploy it to actual production server.
Well, hak makes this extremely simple too!
First, you just need a fresh install of Ubuntu 14.04 server with SSH root access or a user with sudo access. 

```
hak deploy root@x.x.x.x
```

Where x.x.x.x is the IP or hostname of your Ubuntu 14.04 TLS server.
And that's it. 

Hak have installed Docker and Docker Compose on it if it wasn't installed already and then it have rsynced your project folder to the destination server, and then started up the docker-compose up. It also created you a docker-compose-production.yml that you can modify as you wish. 

To push out updates, simply repeat the deploy command and it will rsync it, docker-compose stop, and docker-compose up itself.

## How does it all work?

Hak currently uses Dinghy as a boilerplate to setup many of the things required for an optimal Docker environment on OSX.
It is virtually a one-click setup and even comes with batteries included via Dinghy:

- Docker 
- Docker Machine
- xhyve
- Nginx HTTP Proxy
- DNS
- NFS

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
eval $(dinghy env)
```
