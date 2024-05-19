# Docker

## Images & Containers

> **Containerization** is an approach to software development in which an application or service, its dependencies, and its configuration (abstracted as deployment manifest files) are packaged together as a container image.

Just as shipping containers allow goods to be transported by ship, train, or truck regardless of the cargo inside, software containers act as a standard unit of software deployment that can contain different code and dependencies. Containerizing software this way enables developers and IT professionals to deploy them across environments with little or no modification.

Containers also isolate applications from each other on a shared OS. Containerized applications run on top of a container host that in turn runs on the OS. Containers therefore have a much smaller footprint than virtual machine (VM) images.

In short, containers offer the benefits of isolation, portability, agility, scalability, and control across the entire application lifecycle workflow.

## Containers vs Virtual Machines

A container runs *natively* on Linux and shares the kernel of the host machine with other containers. It runs a discrete process, taking no more memory
than any other executable, making it lightweight.

By contrast, a **virtual machine** (VM) runs a full-blown "guest" operating system with *virtual* access to host resources through a hypervisor. In general,
VMs incur a lot of overhead beyond what is being consumed by your application logic.

![container-architecture](../img/docker_container-architecture.svg "Container Architecture")
![vm-architecture](../img/docker_virtual-machine-architecture.svg "Virtual Machine Architecture")

## [Docker Terminology](https://docs.docker.com/glossary/)

![docker-architecture](../img/docker_architecture.svg "Docker Architecture")

**Container image**: A package with all the dependencies and information needed to create a container. An image includes all the dependencies (such as frameworks) plus deployment and execution configuration to be used by a container runtime. Usually, an image derives from multiple base images that are layers stacked on top of each other to form the container’s filesystem. An image is immutable once it has been created.

**Dockerfile**: A text file that contains instructions for building a Docker image. It’s like a batch script, the first line states the base image to begin with and then follow the instructions to install required programs, copy files, and so on, until you get the working environment you need.

**Build**: The action of building a container image based on the information and context provided by its Dockerfile, plus additional files in the folder where the image is built. You can build images with the following Docker command: `docker build`

**Container**: An instance of a Docker image. A container represents the execution of a single application, process, or service. It consists of the contents of a Docker image, an execution environment, and a standard set of instructions. When scaling a service, you create multiple instances of a container from the same image. Or a batch job can create multiple containers from the same image, passing different parameters to each instance.

**Volumes**: Offer a writable filesystem that the container can use. Since images are read-only but most programs need to write to the filesystem, volumes add a writable layer, on top of the container image, so the programs have access to a writable filesystem. The program doesn’t know it’s accessing a layered filesystem, it’s just the filesystem as usual. Volumes live in the host system and are managed by Docker.

**Tag**: A mark or label you can apply to images so that different images or versions of the same image (depending on the version number or the target environment) can be identified.

**Multi-stage Build**: Is a feature, since Docker 17.05 or higher, that helps to reduce the size of the final images. For example, a large base image, containing the SDK can be used for compiling and publishing and then a small runtime-only base image can be used to host the application.

**Repository (repo)**: A collection of related Docker images, labeled with a tag that indicates the image version. Some repos contain multiple variants of a specific image, such as an image containing SDKs (heavier), an image containing only runtimes (lighter), etc. Those variants can be marked with tags. A single repo can contain platform variants, such as a Linux image and a Windows image.

**Registry**: A service that provides access to repositories. The default registry for most public images is [Docker Hub](https://hub.docker.com/) (owned by Docker as an organization). A registry usually contains repositories from multiple teams. Companies often have private registries to store and manage images they’ve created.

**Multi-arch image**: For multi-architecture, it’s a feature that simplifies the selection of the appropriate image, according to the platform where Docker is running.

**Docker Hub**: A public registry to upload images and work with them. Docker Hub provides Docker image hosting, public or private registries, build triggers and web hooks, and integration with GitHub and Bitbucket.

**Azure Container Registry**: A public resource for working with Docker images and its components in Azure. This provides a registry that’s close to your deployments in Azure and that gives you control over access, making it possible to use your Azure Active Directory groups and permissions.

**Docker Trusted Registry (DTR)**: A Docker registry service (from Docker) that can be installed on-premises so it lives within the organization’s datacenter and network. It’s convenient for private images that should be managed within the enterprise. Docker Trusted Registry is included as part of the Docker Datacenter product. For more information, see [Docker Trusted Registry (DTR)](https://www.docker.com/sites/default/files/Docker%20Trusted%20Registry.pdf).

**Docker Compose**: A command-line tool and YAML file format with metadata for defining and running multi-container applications. You define a single application based on multiple images with one or more `.yml` files that can override values depending on the environment. After you’ve created the definitions, you can deploy the whole multi-container application with a single command (docker-compose up) that creates a container per image on the Docker host.

**Cluster**: A collection of Docker hosts exposed as if it were a single virtual Docker host, so that the application can scale to multiple instances of the services spread across multiple hosts within the cluster. Docker clusters can be created with Kubernetes, Azure Service Fabric, Docker Swarm and Mesosphere DC/OS.

**Orchestrator**: A tool that simplifies the management of clusters and Docker hosts. Orchestrators enable you to manage their images, containers, and hosts through a command-line interface (CLI) or a graphical UI. You can manage container networking, configurations, load balancing, service discovery, high availability, Docker host configuration, and more. An orchestrator is responsible for running, distributing, scaling, and healing workloads across a collection of nodes. Typically, orchestrator products are the same products that provide cluster infrastructure, like Kubernetes and Azure Service Fabric, among other offerings in the market.

---

## Docker CLI

### [`docker run`](https://docs.docker.com/engine/reference/commandline/run/)

```sh
docker run <image>  # run selected app inside a container (downloaded from Docker Hub if missing from image)
docker run -d|--detach <image>  # run docker container in the background (does not occupy stdout & stderr)
docker run -i|--interactive <image>  # run docker container in interactive mode (read stdin)
docker run -t|--tty <image>  # run docker container allocating a pseudo-TTY (show prompts)
docker run -p|--publish <host_port>:<container_port> <image>  # map container ports
docker run -v|--volume <existing_host_dir>:<container_dir> <image>  # map container directory to a host directory (external volumes)
docker run -v|--volume <volume_name>:<container_dir> <image>  # map container directory to a host directory under the docker main folder (external volumes)
docker run -e|--env NAME=value <image>  # set container env vars
docker run --entrypoint <executable> <args> <image>  # run with a non-default entrypoint
docker run --name=<container_name> <image>  # set container name
```

> **Warn**: `<image>` must be last argument

### [`docker container`](https://docs.docker.com/engine/reference/commandline/container/)

```sh
docker container ls  # list of currently running containers
docker container ls -a|--all  # list of all containers, running and exited
docker container rm <container>  # remove one or more containers
docker container prune  # remove stopped containers

docker container inspect <container>  # full details about a container
docker container logs <container>  # see container logs

docker container stop <container>  # stop a running container
docker container start <container>  # start a stopped container

docker container exec <container> <command>  # exec a command inside a container
```

### [`docker image`](https://docs.docker.com/engine/reference/commandline/image/)

```sh
docker image ls  # list of existing images
docker image rm <image>  # remove one or more images
docker image prune <image>  # remove unused images
docker image pull <image>  # download an image w/o starting the container
```

### [`docker build`](https://docs.docker.com/engine/reference/commandline/build/)

```sh
docker build -t <tag> -f <dockerfile> <context>  # build image with specific tag (usually user/app:version)
docker build -t <tag> -f <dockerfile> --build-arg ARG=value <context>  # pass args to ARG steps
```

### [`docker push`](https://docs.docker.com/engine/reference/commandline/push/)

```sh
docker push <image>  # publish image to registry (defaults to Docker Hub)
```

## [Dockerfile](https://docs.docker.com/engine/reference/builder/)

```dockerfile
# starting image or scratch
FROM <base_image>:<tag>

# run commands (e.g: install dependencies)
RUN <command>

# define working directory (usually /app)
WORKDIR <path>

# copy source code into the image in a specified location
COPY <src> <dir_in_container>

# accept args from docker run (--build-arg arg_name=value)
ARG <arg_name>

# set env values inside the container
ENV <ENV_VAR> <value>

# Exec form (Preferred form)
CMD ["<executable>", "<arg1>", "<arg2>"]
ENTRYPOINT ["<executable>", "<arg1>", "<arg2>"]

# Shell form
CMD <executable> <arg1> <arg2>
ENTRYPOINT <executable> <arg1> <arg2>
```

### `CMD` vs `ENTRYPOINT`

`CMD` is used to provide all the default scenarios which can be overridden. *Anything* defined in CMD can be overridden by passing arguments in `docker run` command.

`ENTRYPOINT` is used to define a specific executable (and it's arguments) to be executed during container invocation which cannot be overridden.  
The user can however define arguments to be passed in the executable by adding them in the `docker run` command.

## [Docker Multi-Stage Build](https://docs.docker.com/develop/develop-images/multistage-build/)

With multi-stage builds, it's possible to use multiple `FROM` statements in the Dockerfile. Each `FROM` instruction can use a different base, and each of them begins a new stage of the build.

It's possible to selectively copy artifacts from one stage to another, leaving behind everything not wanted in the final image.

```dockerfile
FROM <base_image>:<tag> AS <runtime_alias>
RUN <command>  # install external dependencies (apt get ...)

# --- START of BUILD LAYERS --- #
FROM <base_image>:<tag> AS <build_alias>
WORKDIR <app_path>
  
# install project dependencies
COPY <src> <dir_in_container>  # add lockfiles
RUN <command>  # install project dependencies from lockfiles
  
COPY <src> .<dir_in_container>  # bring in all source code
WORKDIR <build_location>
ARG version
RUN <command>  # build project
# --- END of BUILD LAYERS --- #

FROM <runtime_alias> AS <deploy_alias>
WORKDIR <app_path>

# bring in release build files
COPY --from=<build_alias|stage_number> <src> <dir_in_container>
CMD ["executable"]  # run app
```

```dockerfile
FROM mcr.microsoft.com/dotnet/<runtime|aspnet>:<alpine_tag> AS runtime
RUN <command>  # install external dependencies (apt get ...)

# --- START of BUILD LAYERS --- #
FROM mcr.microsoft.com/dotnet/sdk:<tag> as build
WORKDIR /app

# install project dependencies
COPY *.sln ./src
COPY src/*.csproj ./src
RUN dotnet restore

# publish app
COPY /src ./src  # bring in all source code
WORKDIR /app/src  # reposition to build location
ARG version
RUN dotnet publish <project>|<solution> -c Release -o out /p:Version=$version
# --- END of BUILD LAYERS --- #

FROM runtime AS final-runtime
WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "<project>.dll"]
```

---

## [Networking](https://docs.docker.com/engine/reference/commandline/network/)

Starting container networks: `bridge` (default), `none`, `host`.

```sh
docker run <image> --network=none/host  # specify a non-default network to be used
docker run <image> --add-host=<hostname>:<ip>  # add hostname mapping
docker network ls  # list all available networks
```

- **Bridge**: Private internal network created by Docker.
  All containers ara attached to this network by default and get an IP in the `172.17.xxx.xxx-172.12.xxx.xxx` series.  
  Containers can access each other by using the IP `172.17.0.1`.  
  It is possible to create multiple sub-networks in the bridge network to isolate groups of containers from each other.
- **Host**: Removes any network isolation between the host and the containers. Cannot run multiple containers on the same port.
- **None**: Containers are not attached to a network and cannot access other containers or the external network.

> **Note**: Mapping `host-gateway` to an hostname allows the container to reach the host network even with networks types different from `host`

### User-defined Networks

```sh
docker network create --driver NETWORK_TYPE --subnet GATEWAY_TP/SUBNET_MASK_SIZE NETWORK_NAME
```

### Embedded DNS

Docker has an internal DNS that allows finding other container by their name instead of their IP. The DNS always runs at the address `127.0.0.11`.

---

## Docker Storage

## File System

```sh
/var/lib/docker
|_<storage_driver>
|_containers
|_image
|_network
|_volumes
| |_specific_volume
|_...
```

### Copy-On-Write

To modify a file during while the container runs docker creates a local copy in the specific container and the local copy will be modified.

### Volumes

**volume mounting**: create a volume under the docker installation folder (`/var/lib/docker/volumes/`).
**bind mounting**: link docker to an exiting folder to be used as a volume.

```sh
docker run -v <existing_dir>:<container_dir> <image>:<tag>  # older command for bind mounting
docker run --mount type=bind, source=:<existing_dir>, target=<container_dir> <image>:<tag>  # modern command for bind mounting
```

---

## Docker Compose

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

Using Compose is basically a three-step process:

1. Define the app’s environment with a `Dockerfile` so it can be reproduced anywhere.
2. Define the services that make up your app in `docker-compose.yml` so they can be run together in an isolated environment.
3. Run `docker-compose up` and Compose starts and runs the entire app.

```yaml
version: 3.x
services:
  <service_name>:
    image: <image_name>
    image: <image_url>
    build: <path>  # path to folder containing a Dockerfile to build the image
    build:
      context: <path>
      dockerfile: <*.Dockerfile>
      args:  # pass args to dockerfile
        ARG: <value>
        - ARG=<value>
    ports: 
      - <host_port>:<container_port>
    extra_hosts:  # add hostname mappings to container network interface config
      - <hostname>:<ip>
      - <hostname>:host-gateway  # map host machine network
    networks:  # attach container to one or more networks
      - <network_name>
    depends_on:  # make sure dependencies are running before this container
      - <container_name>
    environment:  # declare a env vars for this service
      ENV_VAR: <value>
      - ENV_VAR=<value>
    env_file:
      - <path/to/env/file>  # reusable env file
    volumes:
      - "./<rel/path/to/volume>:<in/container/path/to/data>"  # service-dedicated volume
      - "<volume_name>:<in/container/path/to/data>"  # reuseable volume
    healthcheck:
      disable: <bool>  # set to true to disable
      test: curl -f http://localhost  # set to ["NONE"] to disable
      interval:  # interval between checks (default 30s)
      timeout:  # check fail timeout (default 30s)
      retries:  # num of retries before unhealty (default 3)
      start_period:  # container init grace pediod (default 5s)
      start_interval:  # check interval in start period

# reusable volume definitions
volumes:
  - <volume_name>:

# create networks
networks:
  <network_name>:
```
