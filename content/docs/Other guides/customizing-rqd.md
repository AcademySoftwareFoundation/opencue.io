---
title: "Customizing RQD rendering hosts"
linkTitle: "Customizing RQD rendering hosts"
weight: 1
date: 2019-12-05
description: >
  Build custom RQD container images to deploy as OpenCue rendering hosts
---

This guide describes how to customize the default [RQD container image published
on Docker Hub](https://hub.docker.com/r/opencue/rqd). The default RQD container
image doesn't include any rendering software. This guide explains how to create
a custom Dockerfile that builds on the basic `opencue/rqd` image to install
rendering software. The sample code illustrates the steps using version 2.79 of
Blender, but you can adapt the basic ideas in this guide for many other types
of software, including commercial rendering packages, such as Maya.

## Before you begin

This guide follows on from the OpenCue
[quick starts for macOS and Linux](/docs/quick-starts/). Before you work
through the steps in this guide, make sure you have successfully started the
OpenCue sandbox environment and run a basic command-line test job. You'll
also need all of the software and source code you used in the quick start.

## Reviewing a sample Dockerfile

The Opencue project includes a sample `Dockerfile` to illustrate how to install
additional software for RQD containers. You can update the sandbox environment
to build and run the sample `Dockerfile` so that you can submit and run a
rendering job using Blender than just the basic command-line tools illustrated
in the quick start. Before you update the sandbox to run the sample
`Dockerfile`, you might find it useful to review the source code for the
sample container.

To review the sample `Dockerfile`:

1.  Open a terminal.

1.  Run the following command to review the sample `Dockerfile`:

    cat samples/rqd/blender/blender2.79-docker/Dockerfile

    The command outputs the contents of the `Dockerfile`.

    The first section of the file indicates that this `Dockerfile`
    builds on the basic `opencue/rqd` container image hosted on
    Docker Hub:

    ```Dockerfile
    # Builds on the latest base image of RQD from Docker Hub
    FROM opencue/rqd
    ```

    The next section installs all of the dependencies required
    to run Blender 2.79 on the CentOS operating system installed in the
    `opencue/rqd`:

    ```Dockerfile
    # Install dependencies to run Blender on the opencue/rqd image
    RUN yum -y update
    RUN yum -y install \
            bzip2 \
            libfreetype6 \
            libgl1-mesa-dev \
            libXi-devel  \
            mesa-libGLU-devel \
            zlib-devel \
            libXinerama-devel \
            libXrandr-devel

    The final section downloads and extracts the archive for Blender 2.79
    to `/usr/local/blender`:

    ```Dockerfile
    # Download and install Blender 2.79
    RUN mkdir /usr/local/blender
    RUN curl -SL https://download.blender.org/release/Blender2.79/blender-2.79-linux-glibc219-x86_64.tar.bz2 \
            -o blender.tar.bz2
    
    RUN tar -jxvf blender.tar.bz2 \
            -C /usr/local/blender \
            --strip-components=1
    
    RUN rm blender.tar.bz2
    ```

    If you'd like to learn more about the configuration of the default
    `opencue/rqd` container image, view the
    [`rqd/Dockerfile`](https://github.com/AcademySoftwareFoundation/OpenCue/blob/master/rqd/Dockerfile)
    in the `master` branch on GitHub.

## Updating the sandbox environment

To build and run the sample `Dockerfile` in the sandbox environment, you need
to update the `docker-compose.yml` file that defines the deployment. For a
production system, you might make a similar change to update the configuration
files for a container management platform, such as Kubernetes.

To update the sandbox environment to build and run the sample `Dockerfile`:

1.  Open the `sandbox/docker-compose.yml` file in your preferred text
    editor or development environment.

1.  Replace the following lines:

    ```yaml
      rqd:
        image: opencue/rqd
    ```

    With the following code:

    ```yaml
      rqd:
        build:
          context: ./
          dockerfile: ./samples/rqd/blender/blender2.79-docker/Dockerfile
    ```

    This change configures Docker Compose to build your local copy of the 
    Dockerfile in the `samples` directory instead of using the
    `opencue/rqd` image on Docker Hub.

1.  Save your changes.

1.  Before you start Docker Compose, delete any existing OpenCue sandbox
    environment containers:

        docker-compose --project-directory . -f sandbox/docker-compose.yml rm

1.  To re-deploy the sandbox environment, run the following command:

        docker-compose --project-directory . -f sandbox/docker-compose.yml up

## Submitting a rendering job

To run a sample rendering job, you'll need a sample `.blend` Blender file. If
you don't have an existing `.blend` file, the Blender project publishes a
variety of  [demo resources](https://www.blender.org/download/demo-files/).

{{% alert title="Note" color="info"%}}Make sure you download a demo file that works
with Blender 2.79 or earlier.{{% /alert %}}

After you download a suitable `.blend` Blender file, move it to the
`/tmp/rqd/shots` directory. The sandbox environment is configured so that both
your host machine and the RQD container can both access this directory.

To test submitting a Blender job to OpenCue, see
[Submitting jobs](/docs/user-guides/submitting-jobs/).

After you submit a job to OpenCue, you can
[monitor progress in CueGUI](/docs/user-guides/monitoring-your-jobs/).

## Stopping and deleting the sandbox environment

To delete the resources you created in this guide, run the following commands
from a shell:

1.  To stop the sandbox environment, run the following command:

        docker-compose --project-directory . -f sandbox/docker-compose.yml stop

1.  To free up storage space, delete the containers:

        docker-compose --project-directory . -f sandbox/docker-compose.yml rm

## What's next?

*   Learn more about [OpenCue concepts and terminology](/docs/concepts/).
*   Install the full [OpenCue infrastructure](/docs/getting-started/).

