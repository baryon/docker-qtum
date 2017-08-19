### Run in docker

This docker is for developer, it clone the latest source from [Qtum Project Github repository](https://github.com/qtumproject/qtum)

### Run in docker

So simple and fast operation Qtum:
 - [Docker](https://docs.docker.com)
 - [Docker-compose](https://github.com/docker/compose)
 - [Docker-volumes](https://github.com/cpuguy83/docker-volumes)

#### Build qtum images from the latest source

```
docker build --rm -t baryon/qtum:dev .
```

#### Data Folder

```
sudo rm -rf /data/qtum/qtum-data # options 
sudo mkdir -p /data/qtum/qtum-data
sudo chmod a+w /data/qtum/qtum-data
```

### Configuring Bitcoin

You can edit the `qtum.conf` file which is generated in your data directory (see below).

### Data Volumes

By default, Docker will create ephemeral containers. That is, the blockchain data will not be persisted, and you will need to sync the blockchain from scratch each time you launch a container.

To keep your blockchain data between container restarts or upgrades, simply add the `-v` option to create a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/):

```
$ docker run -d --rm --name qtumd -v /data/qtum/qtum-data:/data baryon/qtum
$ docker ps
$ docker inspect qtum-data
```

Alternatively, you can map the data volume to a location on your host:

```
$ docker run -d --rm --name bitcoind -v "$PWD/data:/data" amacneil/bitcoin
$ ls -alh ./data
```

### Using qtum-cli

By default, Docker runs all containers on a private bridge network. This means that you are unable to access the RPC port (8332) necessary to run `qtum-cli` commands.

There are several methods to run `qtum-cli` against a running `qtumd` container. The easiest is to simply let your `qtum-cli` container share networking with your `qtumd` container:

```
$ docker run -d --rm --name qtumd -v /data/qtum/qtum-data:/data baryon/qtum:dev
$ docker run --rm --network container:qtumd baryon/qtum:dev qtum-cli getinfo
```
