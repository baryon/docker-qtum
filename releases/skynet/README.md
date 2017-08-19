### Run in docker

So simple and fast operation Qtum:


### Run in docker

So simple and fast operation Qtum:
 - [Docker](https://docs.docker.com)
 - [Docker-compose](https://github.com/docker/compose)
 - [Docker-volumes](https://github.com/cpuguy83/docker-volumes)

#### Pull a image from Public Docker hub

```
$ docker pull baryon/qtum:0.14.0
```

#### OR, Build qtum images

```
docker build --rm -t baryon/qtum:0.14.0 .
```

#### Start docker

```
sudo rm -rf /data/qtum/qtum-data # options 
sudo mkdir -p /data/qtum/qtum-data
sudo chmod a+w /data/qtum/qtum-data
docker-compose -f docker-compose.yml up qtumd
```

### Launch qtumd

To launch your node, simply type `docker-compose up`:

```sh
$ docker-compose up -d qtumd # start qtumd in the background
$ docker-compose ps     # show running processes
$ docker-compose down   # stop qtumd (blockchain data will remain on disk)
```

### Run qtum-cli

To run commands against your running qtum node, a `qtum-cli` shorthand is provided. Simply use the `docker-compose run` command:

```sh
$ docker-compose run --rm qtum-cli getinfo
```

Note that passing `--rm` to `docker-compose run` is not strictly necessary. However, it will prevent exited containers building up on your system after each command, which can waste disk space. If you forget to pass `--rm`, the unused containers will be cleaned up next time you run `docker-compose down`.

