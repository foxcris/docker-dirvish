# Docker Container running dirvish
 
## Configuration
 
###Configuration files, log files, buisness data
The following directories can be loaded from the host to keep the data and configuration files out of the container:

 | PATH in container | Description |
 | ---------------------- | ----------- |
 | /etc/dirvish | Directory of all dirvish configuration files. If this directory is empty on start default dirvish configuration is provided. |
 | /root | Store ssh key to use, and known ssh host fingerprints |
 | /var/log | Logging directory |
 | /backup | Storage directroy to use in dirvish jobs |

## Container Tags

 | Tag name | Description |
 | ---------------------- | ----------- |
 | latest | Latest stable version of the container |
 | stable | Latest stable version of the container |
 | dev | latest development version of the container. Do not use in production environments! |

## Usage

To run the container and store the data and configuration on the local host run the following commands:
1. Create storage directroy for the configuration files, log files and data. Also create a directroy to store the necessary script to create the docker container and replace it (if not using eg. watchtower)
```
mkdir /srv/docker/dirvish
mkdir /srv/docker-config/dirvish
```

2. Create and store you ssh key
```
mkdir /srv/docker/dirvish/root
mkdir /srv/docker/dirvish/root/.ssh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

```
As storage directory use the created "/srv/docker/dirvish/root/.ssh" directory.

3. Create the docker container and configure the docker networks for the container. I always create a script for that and store it under
```
touch /srv/docker-config/dirvish/create.sh
```
Content of create.sh:
```
#!/bin/bash

docker pull foxcris/docker-dirvish
docker create\
 --restart always\
 --name dirvish\
 --volume "/srv/docker/dirvish/etc/dirvish:/etc/dirvish"\
 --volume "/srv/docker/dirvish/root:/root"\
 --volume "/srv/docker/dirvish/var/log:/var/log"\
 --volume "/srv/docker/dirvish/backup:/backup"\
 foxcris/docker-dirvish
```

4. Create replace.sh to install/update the container. Store it in
```
touch /srv/docker-config/dirvish/replace.sh
```
```
#/bin/bash
docker stop dirvish
docker rm dirvish
./create.sh
docker start dirvish
```
