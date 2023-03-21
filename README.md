# docker-tarlz

A Dockerfile of [tarlz](https://lzip.nongnu.org/tarlz.html), which is an archiver with lzip.


## How to build a image

```shell
$ git clone https://github.com/kyo1/docker-tarlz.git
$ cd docker-tarlz
$ make
```

## How to use

See help with the following command.

```shell
$ docker run -it --rm -v "$(pwd)":/usr/src tarlz --help
```

The examples are the following.

```shell
# Create a new compressed archive from files
$ docker run -it --rm -v "$(pwd)":/usr/src tarlz -9 -cvf files.tar.lz file1 file2 file3 ...

# Extract all files from an archive
$ docker run -it --rm -v "$(pwd)":/usr/src tarlz -xvf files.tar.lz

# List the contents of an archive
$ docker run -it --rm -v "$(pwd)":/usr/src tarlz -tvf files.tar.lz

# Append files to an archive
$ docker run -it --rm -v "$(pwd)":/usr/src tarlz -rvf files.tar.lz file1 file2 file3 ...
```
