# bash_it

**bash_it** demos a crash caused by a mismatch between root volume mounts in Windows Subsystem for Linux and Hyper-V.  
- Docker client in WSL uses `/mnt/c` (Linux convention)
- Docker engine in Hyper-v uses `/c` (Windows convention)

The result of this mismatch is rendered as an attempt to map an unknown directory (because the file could not be properly resolved) into a file.

Produced with Windows 10 _build 1503.11_ running Xenial _16.04.2 LTS_ with docker client _17.03.0_ connecting to the hyper-V docker-for-windows daemon _17.03.1_ and docker-compose _1.11.1_

## to run
```BASH
$ git clone https://github.com/ej3/bash_it.git 
$ cd bash_it
$ ./bash_it.sh
```

## expected output
```BASH
$ ./bash_it.sh
Sending build context to Docker daemon 53.76 kB
Step 1/3 : FROM bash:latest
 ---> a0a73a853323
Step 2/3 : COPY ./test.conf /etc/test.conf
 ---> 4cfda7391790
Removing intermediate container 18335c55402f
Step 3/3 : CMD cat /etc/test.conf
 ---> Running in 3fe190ae11fa
 ---> f06be46d32c7
Removing intermediate container 3fe190ae11fa
Successfully built f06be46d32c7
Creating network "example_default" with the default driver
Creating example_bash_it_1

ERROR: for bash_it  Cannot start service bash_it: oci runtime error: container_linux.go:247: starting container process caused "process_linux.go:359: container init caused
\"rootfs_linux.go:54: mounting \\\"/mnt/c/bash_it/test.dev.conf\\\" to rootfs \\\"/var/lib/docker/overlay2/6c9625b0f1c120ba262f1e2dee8596b54d8
08f3938f53311d9c71473dc518023/merged\\\" at \\\"/var/lib/docker/overlay2/6c9625b0f1c120ba262f1e2dee8596b54d808f3938f53311d9c71473dc518023/merged/etc/test.conf\\\" caused \\
\"not a directory\\\"\""
: Are you trying to mount a directory onto a file (or vice-versa)? Check if the specified host path exists and is the expected type
ERROR: Encountered errors while bringing up the project.

Removing example_bash_it_1 ... done
Removing network example_default
Untagged: bash_it:latest
Deleted: sha256:f06be46d32c7ca6183784b451d5cd91ff5e4ceb8e094093370d12c97a07f627a
Deleted: sha256:4cfda7391790f28567588536956504e1c717186a53810e47a4233eb1a039d85f
Deleted: sha256:ec536a13882b8b64db76db39c02d2528e7223486764d1b4c7a5b307dbe4644c7
```
### follow issue
- [Microsoft/BashOnWindows#1854](https://github.com/Microsoft/BashOnWindows/issues/1854)
- [docker/for-win#371](https://github.com/docker/for-win/issues/371)

