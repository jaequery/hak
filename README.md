# Hak

## What is it
Hak is a CLI that pulls code, hosts your app, and deploy it to a remote server.

It provides you with an out of the box, over-simplified web development flow for your Mac OSX or Ubuntu. 

In just a single command, you can now host any number of apps ranging from Node.js, PHP, to Ruby applications without juggling through VM's, ports, and services.

## What does it do

Hak covers the entire process of an app development cycle in an elegant fashion:

- It pulls code / application - just like NPM/APT
- It hosts your application with a hostname - http://yourapp.docker 
- Deploy your app to an Ubuntu server 

Here is how that process looks like:

```sh
hak clone jaequery/honeybadger yourapp
cd yourapp
hak start
```

And after you are done coding, to deploy, you just:

```sh
hak deploy root@yourserver.com
```

## Hak is for you, if:
- You are a one-click kind of guy and loves saving time
- You wanted a more elequent way of managing your apps than through ports, IPs, and hosts file
- You work on multiple languages and platforms (PHP, Node.js, Ruby, and etc...)
- You love Docker
- You love bootstraps

Basically, if you are a coder, Hak is for you. =P

## Getting Started

#### Pre-requisites

* Mac OSX "Yosemite or El Capitan"
* Docker for Mac OSX

#### Install Docker for Mac OSX
You can get it from here [https://docs.docker.com/docker-for-mac](Docker for Mac OSX)

#### Download hak

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

