# Guide to setting up remote kernels in docker containers for Atom

This guide will provide the steps needed to setup a docker image on a remote server/computer and then use SSH port forwarding to allow the Atom IDE on a remote machine on the same network to connection to the Jupyter kernels and run code remotely

---
## Remote Server Setup

### Docker

We are going to be using Docker containers to isolate our various environments.  Starting out we will be just creating a general use container that we can use to run R and Python code on.  In the future we will have multiple docker images that we can launch to segregate our various coding environments similar to conda environments or virutalenv.

#### Install Docker
For installation on Ubuntu 18.04 use this guide provided by DigitalOcean

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

#### Create Dockerfile
In the atom-test folder located in this repo I have added 3 files that will create a Docker image with the following items.
- Based off off continuumio's miniconda3 image
- Installs Jupyter Lab and Notebooks
- Installs various python packages and python kernel for Data science
  - numpy
  - pandas
  - seaborn
  - scikit-learn
- Installs R packages and kernel
- Autostarts a notebook on port 22222 with no access token

### Build container
1. Download the files in the atom-test directory to your machine
2. Navigate to that directory
3. Run the command `docker build -t <docker_name> .'` where <docker_name> is what you the container to be called

### Scripts for SSH Port Forwarding
You will need to place the `start_atom_docker.sh` and the `stop_atom_docker.sh` script in a folder on your server and make them executable. I have mine placed under my home folder in a directory called scripts that has been added to my $PATH variable (/home/$USER/scripts).

---
## User Laptop/Desktop Setup

### Install Atom
Download from the Atom website (https://atom.io)

#### Install Plugins
Install the plugins below using either APM or the Atom UI

`apm install hydrogen hydrogen-launcher platformio-ide-terminal`

- Hydrogen
  - https://atom.io/packages/hydrogen
- PlatformIO IDE Terminal
  - https://atom.io/packages/platformio-ide-terminal
- Hydrogen Launcher
  - https://atom.io/packages/hydrogen-launcher

### SSH Port forwarding

Place the file `remote-atom` on your client computer in a directory that is in your $PATH and make it executable.  You can then run the script with your target machines DNS name and the action (start/stop).  This will start SSH port forwarding between your server and computer on port 22222 and it will start or stop the docker container.

Usage:
```
remote-atom -t <target> -a <action>
ex. remote-atom -t ubuntu-server.local.lan -a start
```

_There are some limitations with the script.  It assumes that your local network uses .local.lan and you need to specify your user in the script.  You will also need to have setup SSH certificates between the client and the server._

---




_Big Thanks to Jeff Stafford's blog for setting the ground work (https://jstaf.github.io/2018/03/25/atom-ide.html)_
