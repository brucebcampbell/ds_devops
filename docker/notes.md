
#DockerHub

```
docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname
```

### Make Dockerfile
```
cat > Dockerfile <<EOF
FROM busybox
CMD echo "DSMS - Test Image"
EOF
```
###Build
```
docker build -t wavescholar/data-science-microservices .
```
#### Push to Microservices Docker Repository
```
docker push wavescholar/data-science-microservices:tagname
```

### List and Display Commands

```
docker
docker container --help

docker version
sudo docker info

## Execute Docker image
sudo docker run hello-world

## List Docker images
sudo docker image ls

## List Docker containers (running, all, all in quiet mode)
sudo docker container ls
sudo docker container ls --all
sudo docker container ls -aq
```

```
sudo docker image ls
sudo docker build .
sudo docker image ls
sudo docker image tag 02e9e8a189e5 quay.io/brcampbe/ubuntu18_cuda
sudo docker login quay.io
sudo docker push quay.io/brcampbe/ubuntu18_cuda
sudo docker container ls -all
sudo docker container run -dit quay.io/brcampbe/ubuntu18_cuda
```
