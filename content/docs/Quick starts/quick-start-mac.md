---
title: "Quick start for macOS"
linkTitle: "Quick start for macOS"
weight: 2
date: 2019-09-04
description: >
  Try OpenCue in the sandbox environment on macOS
---

OpenCue is an open source render management system. You can use
OpenCue in visual effects and animation production to break down
complex jobs into individual tasks. You can submit jobs to a
queue that allocates rendering resources. You can also monitor
rendering jobs from your workstation.

The sandbox environment provides a way to quickly start a test OpenCue
deployment. You can use the test deployment to run small tests or for
development work. The sandbox environment runs OpenCue components in
separate Docker containers on your local machine.

This quick start takes approximately 20 minutes to complete.

## Before you begin

You must have the following software installed on your machine:

*   Python version 2.7 or greater
*   The Python [`pip` command](https://pypi.org/project/pip/)
*   The Python [virtualenv tool](https://pypi.org/project/virtualenv/)
*   [Docker](https://docs.docker.com/install/)
*   [Docker Compose](https://docs.docker.com/compose/install/)
*   The `wget` command

{{% alert title="Note" color="info"%}}Docker compose is included in the
desktop installation of Docker on macOS.{{% /alert %}}

You must allocate a minimum of 6 GB of memory to Docker. To learn
how to update the memory limit on macOS, see
[Get started with Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/#advanced).

To install the `wget` command, you can use [Homebrew](https://brew.sh/):

    brew install wget

If you don't already have a recent local copy of the OpenCue source code, you
must do one of the following:

1.  Download and unzip the
    [OpenCue source code ZIP file](https://github.com/AcademySoftwareFoundation/OpenCue/archive/master.zip).

1.  If you have the `git` command installed on your machine, you can clone
    the repository:

        git clone https://github.com/AcademySoftwareFoundation/OpenCue.git

## Deploying the OpenCue sandbox environment

You deploy the sandbox environment using
[Docker Compose]([https://docs.docker.com/compose/]), which runs the
following containers:

*   a PostgresSQL database
*   a Cuebot server
*   an RQD rendering server

{{% alert title="Note" color="info"%}}In a production OpenCue deployment,
you might run many hundreds of RQD rendering servers.{{% /alert %}}

The Docker Compose deployment process also configures the database and applies
any database migrations. The deployment process creates a `db-data` directory
in the `sandbox` directory. The `db-data` directory is mounted as a volume in
the PostgresSQL database container and stores the contents of the database. If
you stop your database container, all data is preserved as long as you don't
remove this directory. If you need to start from scratch with a fresh
database, remove the contents of this directory and restart the containers
with the `docker-compose` command.

Docker Compose mounts volumes for the RQD rendering server on the host
operating system under `/tmp/rqd/logs` and `/tmp/rqd/shots`. RQD saves logs
to the `logs` directory. You specify the `shots` directory to save RQD output
when creating OpenCue jobs. On macOS, the `docker-compose` command
automatically creates the mount points for you.

To deploy the OpenCue sandbox environment:

1.  Start the Terminal app.

1.  Change to the root of the OpenCue source code directory:

        cd OpenCue

1.  To deploy the OpenCue sandbox environment, export the `CUE_FRAME_LOG_DIR`
    environment variable:

    {{% alert title="Note" color="info"%}}You must export all environment
    variables each time you start the sandbox.{{% /alert %}}

        export CUE_FRAME_LOG_DIR=/tmp/rqd/logs

1.  To specify a password for the database, export the `POSTGRES_PASSWORD`
    environment variable:

        export POSTGRES_PASSWORD=<REPLACE-WITH-A-PASSWORD>

1.  Build the RQD container from source:

    {{% alert title="Note" color="info"%}}This is a temporary workaround
    due to a bug related to RQD in version 0.3.6 of OpenCue.{{% /alert %}}

        docker build -t opencue/rqd -f rqd/Dockerfile .

1.  To deploy the sandbox environment, run the `docker-compose` command:

        docker-compose --project-directory . -f sandbox/docker-compose.yml up

    The command produces a lot of output. When the setup process completes,
    you see output similar to the following example:

        rqd_1     | 2019-09-03 16:56:09,906 WARNING   rqd3-__main__   RQD Starting Up
        rqd_1     | 2019-09-03 16:56:10,395 WARNING   rqd3-rqcore     RQD Started
        cuebot_1  | 2019-09-03 16:56:10,405 WARN pool-1-thread-1 com.imageworks.spcue.dispatcher.HostReportHandler - Unable
         to find host 172.18.0.5,org.springframework.dao.EmptyResultDataAccessException: Failed to find host 172.18.0.5 , c
        reating host.

Leave this shell running in the background.

## Installing the OpenCue client packages

OpenCue includes the following client packages to help you submit,
monitor, and manage rendering jobs:

*   PyCue is the OpenCue Python API. OpenCue client-side Python tools, such as
    CueGUI and `cueadmin`, all use PyCue for communicating with your OpenCue
	deployment.
*   PyOutline is a Python library that provides a Python interface to the
    job specification XML. You can use PyOutline to construct complex jobs with
	Python code instead of working directly with XML. 
*   CueSubmit is a graphical user interface for configuring and launching
    rendering jobs to an OpenCue deployment.
*   CueGUI is a graphical user interface you run to monitor and manage jobs,
    layers, and frames.
*   `cueadmin` is the OpenCue command-line client for administering an OpenCue
    deployment.
*   `pycuerun` is a command-line client for submitting jobs to OpenCue.

To install the OpenCue client packages:

1.  Open a second Terminal window.

1.  Change to the root of the OpenCue source code directory:

        cd OpenCue

1.  Create a virtual environment for the Python packages:

        virtualenv venv

1.  Activate the `venv` virtual environment:

        source venv/bin/activate

1.  To install the lastest versions of the OpenCue client packages, you must
    configure the installation script with the version number. You can look up
    the version numbers for
    [OpenCue releases on GitHub](https://github.com/AcademySoftwareFoundation/OpenCue/releases).

        export VERSION=0.2.65

1.  Install the Python dependencies and client packages in the `venv` virtual
    environment:

        sandbox/install-client-archives.sh

    {{% alert title="Note" color="info"%}}Alternatively, you can install the
    client packages from your local clone of the source code. However, the
    latest version of the OpenCue source code might include changes that are
    incompatible with the prebuilt OpenCue images of Cuebot and RQD on
    Docker Hub used in the sandbox environment. To install from source, run
    `sandbox/install-client-sources.sh`.{{% /alert %}}

## Testing the sandbox environment

To connect to the sandbox environment, you must first configure your local
client packages to:

*   Locate the `outline.cfg` PyOutline configuration file included in the
    OpenCue Git repository.
*   Locate the Cuebot server running in a Docker container on your machine.

To test the sandbox environment, run the following commands from the second
Terminal window:

1.  Set the location of the PyOutline configuration file:

    {{% alert title="Note" color="info"%}}You must export all environment
    variables each time you start the client packages.{{% /alert %}}

        export OL_CONFIG=pyoutline/etc/outline.cfg

1.  The Cuebot docker container is forwarding the gRPC ports to your
    localhost, so you can connect to it as `localhost`:
    
        export CUEBOT_HOSTS=localhost

1.  To verify the successful installation of the sandbox environment, as well
    as the connection between the client packages and sandbox, you can run the
    `cueadmin` command-line tool. To list the hosts in the sandbox
    environment, run the following `cueadmin` command:

        cueadmin -lh

    The command produces output similar to the following:

        Host            Load NIMBY freeMem  freeSwap freeMcp   Cores Mem   Idle             Os       Uptime   State  Locked    Alloc      Thread 
        172.18.0.5      52   False 24.2G    0K       183.1G    2.0   25.5G [ 2.00 / 25.5G ] Linux    00:04    UP     OPEN      local.general AUTO

1.  Launch the CueSubmit app for submitting jobs:

        cuesubmit &

    The following screenshot illustrates the layout of CueSubmit as a
    standalone app:

    ![The default CueSubmit window](/docs/images/cuesubmit_quickstart.png) 

1.  By default, the OpenCue sandbox environment doesn't include any rendering
    software. To experiment with the user interface, you can execute simple
    command-line shell scripts.

    To execute a command-line shell script:

    * For **Job Name**, type `HelloWorld`.
    * For **User Name**, type `test-user`.
    * For **Shot**, type `test-shot`.
    * For **Layer Name**, type `test-layer`.
    * For **Command To Run**, type the following command:

    ```bash
    echo "Output from frame: #IFRAME#; layer: #LAYER#; job: #JOB#"
    ```

    * For **Frame Spec**, type `1-10`.

    This job consists of 10 frames, which each run a simple `echo` command.
    For each frame, the `echo` command prints the frame number, layer name,
    and job name using replacement tokens such as `#IFRAME#` and `#JOB#`.

1.  To submit the job to OpenCue, click **Submit**.

1.  Launch the CueGUI Cuetopia app for monitoring jobs:

        cuegui &

    The following screenshot illustrates the layout of CueGUI Cuetopia
    monitoring app:

    ![The default CueGUI Cuetopia window](/docs/images/cuegui_quickstart.png) 

1.  Click **Load**.

    CueGUI displays the job name `testing-test-shot-test-user_helloworld` in
    the list of jobs.

1.  Double-click the job name.

    CueGUI displays the list of frames in the job.

1.  After OpenCue marks the status of a frame as `SUCCEEDED`, click the
    corresponding row in the list of frames.

1.  In the LogView view, review the log output for the job to verify the frame
    produced output similar to the following:

        Output from frame: 9; layer: test_layer; job: testing-test-shot-test-user_helloworld

## Stopping and deleting the sandbox environment

To delete the resources you created in this guide, run the following commands
from the second shell:

1.  To stop the sandbox environment, run the following command:

        docker-compose --project-directory . -f sandbox/docker-compose.yml stop

1.  To free up storage space, delete the containers:

        docker-compose --project-directory . -f sandbox/docker-compose.yml rm

1.  To delete the virtual environment for the Python client packages:

        rm -rf venv

## What's next?

*   To test submitting a Blender rendering job, see
    [Customizing RQD rendering hosts](/docs/other-guides/customizing-rqd).
*   Learn more about [OpenCue concepts and terminology](/docs/concepts/).
*   Install the full [OpenCue infrastructure](/docs/getting-started/).
