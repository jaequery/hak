# Hak

## What is it

Hak provides you with a light and simple web development environment for your Mac OSX or Ubuntu. 

It is a CLI that pulls code, hosts your app, and deploys it to a remote server.

In just a single command, you can now host any number of apps ranging from Node.js, PHP, to Ruby and Java applications without juggling through multiple VM's, ports, and services.

## What does it do

Hak covers the entire process of an app development cycle in an elegant fashion:

- It pulls code / application and sets up the docker-compose.yml file
- It provides a name-based hosting of your applications, http://yourapp.docker (and not http://127.0.0.1:3000)
- It deploys and launches your app to a remote Ubuntu server

Here is how that process looks like:

```sh
hak clone jaequery/honeybadger yourapp
cd yourapp
hak start
```

Now you should be able to view your website at http://yourapp.docker/

Lastly, after you are done coding, to deploy you simply just:

```sh
hak deploy root@yourserver.com
```

## Hak is for you, if:
- You are a 1-click kind of guy
- You want an elequent way of managing your apps and hate juggling ports/IPs/hosts file
- You work on multiple languages and platforms (PHP, Node.js, Ruby, and etc...)
- You love Docker 
- Your middlename is rapid-development

Basically, if you code, Hak is for you. =P

## Getting Started

#### Pre-requisites

Hak have been tested on OSX but it can also work in Ubuntu as well.
* docker + docker compose

#### Install Docker

##### For Mac OSX
First, download this and install it [https://docs.docker.com/docker-for-mac](Docker for Mac OSX)
Hak will not function without docker and docker-compose.

#### Download hak

Note: Hak is currently bundled as a ruby gem package.

```sh
gem install hak
```

#### Install Hak

Installs the DNS resolver and a reverse proxy.

```sh
hak install
```

#### Power on Hak

Now power it on by typing:

```
hak on
```

To verify that it all working, just type the following:

```
hak ps
```

You should see proxy is up and running, which is the amazing jwilder nginx proxy that hak uses for virtual hosting all your websites.

#### Let's create a site

Now go into a folder where you'd like to store all your websites, for instance: ~/Sites.

Let's clone one of these bad boys:

Here is my personal favorite:

[honeybadger](https://github.com/jaequery/honeybadger)
- a Ruby hackathon framework using Sinatra/Postgres with admin + ORM included
```
hak clone jaequery/honeybadger mysite.com
```

And here is for the Node.js+React fans out there:

[react-starter](https://github.com/jaequery/react-starter)
- an express + react + mongo
```
hak clone jaequery/react-starter mysite.com
```

This will have created a ./mysite.com folder with a docker-compose.yml setup with a VIRTUAL_HOST=mysite.com.docker embedded in it.

#### Start the site

```sh
cd mysite.com
hak start
```

Your site should now be viewable at http://mysite.com.docker/ from your browser (don't forget the trailing slash).
You can also modify the VIRTUAL_HOST manually by editing the docker-compose.yml file yourself.

Note) Once started, your prompt will attach itself to docker-compose logs -f, and you can hit Ctrl-c to escape out. 
To get back to the logs, you can type: ```hak logs```

And to stop the site:

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

## Special thanks

I'd like to mention that none of this would've been possible if not for these brilliant opensource projects:

- https://github.com/docker
- https://github.com/jwilder/nginx-proxy
- https://github.com/codekitchen/dinghy
- https://github.com/FreedomBen/dory
- https://github.com/andyshinn/docker-dnsmasq
