---
title: "Setting up a development environment on Linux"
linkTitle: "Setting up a development environment on Linux"
date: 2020-03-24
weight: 1
description: >
  Set up your development environment on Linux
---

This is a guide to setting up a development environment on Linux that lets
you run the entire OpenCue system, including Cuebot, CueGUI, and RQD. After
you complete the setup, you can make changes to any part of the development
environment.

## Before you begin

First, clone the
[OpenCue git repository](https://github.com/AcademySoftwareFoundation/OpenCue)
to your machine. You also need to download and install OpenCue's core
dependencies:

- [PostgreSQL](https://www.postgresql.org/download/linux/ubuntu/) version 9 or
  greater.
  - We recommend installing Postgres using a `yum`-based Linux distribution, such as
  [CentOS](https://www.centos.org/):

   1. First, run `yum` to install the required Postgres packages:

       ```shell
       yum install postgresql-server postgresql-contrib
       ```

   1. Next, initialize your Postgres installation and configure it to run as a
    service:

       ```shell
       postgresql-setup initdb
       systemctl enable postgresql.service
       systemctl start postgresql.service
       ```

   1. Create a superuser named after your current OS user, which is used for the
    rest of the admin commands in this guide.

       ```shell
       su -c "createuser -s $USER" postgres
       ```
- [Python 3.x](https://www.python.org/downloads/) 
- [Java SE JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html)
  version 11 or greater
  It's also useful to install an IDEs. JetBrains has free community versions of
  the following options:

- [PyCharm](https://www.jetbrains.com/pycharm/) for Python
- [IntelliJ IDEA](https://www.jetbrains.com/idea/download/#section=linux) for Java


## Database setup

After installing PostgreSQL you need to create a database and user for OpenCue — specifically
Cuebot — to use.

### Using the command-line

To set up the database using the command-line:

1. Define and export the following shell variables for a database named `cuebot_local`:
   
   ```shell
   export DB_NAME=cuebot_dev
   export DB_USER=cuebot
   export DB_PASS=changeme
   export DB_HOST=localhost
   ```

1. Create the database and the user that Cuebot uses to connect to it:

   ```shell
   createdb $DB_NAME
   createuser $DB_USER --pwprompt
   # Enter the password stored in DB_PASS when prompted
   psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO $DB_USER" $DB_NAME
   ```

1.  Change your current directory to the root of your OpenCue Git clone.

1.  Visit https://github.com/AcademySoftwareFoundation/OpenCue/releases and download the SQL files
    from the latest release's Assets. There should be two - a `schema` file and a `demo_data` file.

1.  Populate the database schema and some initial data, run the `psql`
    command:

    ```shell
    psql -h $DB_HOST -f <path to schema SQL file> $DB_NAME
    ```

1.  The `demo_data` SQL file contains a series of SQL commands to insert some
    sample data into the Cuebot database, which helps demonstrate various
    features of the software. To execute the SQL statements, run the `psql`
    command:

    ```shell
    psql -h $DB_HOST -f <path to demo_data SQL file> $DB_NAME
    ```
    To see a list of flags for the `psql` tool, run the `psql --help` command. For example, if
    your database is running on a remote host, specify the `-h` flag. If you need to specify a
    different username, specify the `-U` flag.

## Running Cuebot

Cuebot is the core component of OpenCue, written in Java. It serves the gRPC API which all
other components use to interact with the database, and is responsible for dispatching work
to RQD worker nodes.

To build and run it with IntelliJ IDEA:

1. Open IntelliJ IDEA and choose **Import Project**, select the `cuebot` folder in the git
   repository.
   
1. Choose the **Import project from external model > Gradle** option then click **Finish**.

1. Click **Build > Rebuild Project**.

   IntelliJ downloads Gradle and all source dependencies, then compiles the project and
   runs tests.

1. Browse to the `src/main/java/com.imageworks/spcue/CuebotApplication` file.

1. Click **Edit 'CubotApplicat....main()'...**.

1. Update the **Program arguments** as follows and replace the value for `<PASSWORD>`
   where indicated:

   ```
   --datasource.cue-data-source.jdbc-url=jdbc:postgresql://localhost/cuebot_dev --datasource.cue-data-source.username=cuebot --datasource.cue-data-source.password=<PASSWORD>
   ```
 
1. Click **OK**.
 
1. Click **Run** > **Run 'CuebotApplication'**.

1. Verify that the output window doesn’t show any errors.

   If it does, double-check that you have set up the database correctly,
   including permissions, and have set the Program arguments correctly.

## Create a virtual environment

OpenCue consists of multiple Python components which are interrelated. These components
include RQD, CueGUI, and the Python API.

We recommend creating a Python virtual environment specifically for development use that you can
use for all components. This will help keep dependencies synchronized across your OpenCue
deployment.

1. Open a terminal and change to the root folder of your OpenCue Git clone.

1. Create a virtual environment named `venv-dev`:

   ```shell
   sudo python3 -m venv venv-dev
   ```
   
   Your virtual environment can be named whatever you want; this rest of this guide assumes
   you're using one named `venv-dev`.
   
1. Activate the virtual environment:

   ```shell
   source venv-dev/bin/activate
   ```

## Configure PyCharm

Similar to the virtual environment, we recommend configuring your IDE as a single project
containing all of the Python components. PyCharm is used here.

1. Open PyCharm and choose **Open**. Select the root folder of the git repository.

1. Open the PyCharm preferences and navigate to **Project: opencue > Project Interpreter**.

1. Add a new interpreter, using the following settings:
   
   - **Virtual environment**
   - **Existing environment**
   - **Interpreter** set to `<path to git repository>/venv-dev/bin/python`

1. PyCharm should prompt you to install 'Package requirements'. This will install OpenCue's
   Python dependencies into your virtual environment.
   
   This can take a few minutes, namely to download `PySide2`.

1. In order for inter-dependencies within the code to work in PyCharm you need to mark
   each components as a source directory. In the PyCharm file browser, right-click on
   each OpenCue component and click on **Mark Directory As > Sources Root**. You
   need to do this for:
   
   - `cueadmin/`
   - `cuegui/`
   - `cuesubmit/`
   - `proto/`
   - `pycue/`
   - `pyoutline/`
   - `rqd/`

## Generate gRPC Python code

The OpenCue data model and gRPC API are defined using
[`.proto` Protobuf files](https://developers.google.com/protocol-buffers). To make use of
these definitions at runtime the Protobuf files must first be "compiled" into native code —
Java and Python in our case, though Protobuf supports many languages. This increases consistency
across OpenCue components and reduces code repetition.

Generating the Python versions of OpenCue's `.proto` files for RQD and the PyCue library is
currently a manual process. To generate the Python code:

1. Open a terminal, change to the root directory of the Git clone, and activate your
   virtual environment as described above.

1. Install the required gRPC tools:

    ```shell
    sudo pip -m install grpcio-tools
    ```

1. Change directory to the `proto` folder.

1. Generate the Python versions of the gRPC classes:

    ```shell
    python -m grpc_tools.protoc --proto_path=. --python_out=../rqd/rqd/compiled_proto --grpc_python_out=../rqd/rqd/compiled_proto *.proto
    python -m grpc_tools.protoc --proto_path=. --python_out=../pycue/opencue/compiled_proto --grpc_python_out=../pycue/opencue/compiled_proto *.proto
    ```

    The `.proto` files also need some post-processing to make them compatible
    with Python 3. The easiest way to do this is to install and run the `2to3`
    package.

1. Run the following commands to install the `2to3` package and complete the
   post-processing:

    ```shell
    sudo pip install 2to3
    2to3 -wn -f import ../rqd/rqd/compiled_proto/*_pb2*.py
    2to3 -wn -f import ../pycue/opencue/compiled_proto/*_pb2*.py
    ```

## Running RQD

RQD is the OpenCue rendering host agent, written in Python.

To run RQD with PyCharm, right-click `rqd/__main__.py` and click **Run**.

{{% alert title="Note" color="info"%}}RQD by default will look at `localhost` for a
Cuebot server. If you want to point at a different Cuebot,
[set the `CUEBOT_HOSTNAME` environment variable](https://www.jetbrains.com/help/pycharm/creating-and-editing-run-debug-configurations.html).{{% /alert %}}

## Running CueGUI

CueGUI lets you monitor the status of jobs and rendering hosts, written in Python.

To run CueGUI with PyCharm, right-click `cuegui/__main__.py` and click **Run**.

{{% alert title="Note" color="info"%}}CueGUI by default will look at `localhost` for a
Cuebot server. If you want to point at a different Cuebot,
[set the `CUEBOT_HOSTS` environment variable](https://www.jetbrains.com/help/pycharm/creating-and-editing-run-debug-configurations.html).
This can be a single hostname/IP address or a comma-separated list of addresses.{{% /alert %}}

## Running CueSubmit

CueSubmit lets you submit jobs to OpenCue, written in Python.

To run CueSubmit with PyCharm, right-click `cuesubmit/__main__.py` and click **Run**.

{{% alert title="Note" color="info"%}}CueSubmit by default will look at `localhost` for a
Cuebot server. If you want to point at a different Cuebot,
[set the `CUEBOT_HOSTS` environment variable](https://www.jetbrains.com/help/pycharm/creating-and-editing-run-debug-configurations.html).
This can be a single hostname/IP address or a comma-separated list of addresses.{{% /alert %}}

## Verify your installation

After you are running Cuebot, CueGUI, and RQD simultaneously, you should be
able to see the RQD host in CueGUI:

1. From the **Views/Plugins** menu, click **Cuecommander** > **Monitor Hosts**.

1. In the **Monitor Hosts** section, check the **Auto-refresh** box as
illustrated by the following screenshot:

   ![A screenshot of CueGUI showing host](/docs/images/windows/verify_host.png)

    Next, check that you can run a job by using CueSubmit.

1. Switch to CueSubmit and fill out Job, Shot, and Layer Name fields as
   you like.

1. Set the Command to `echo #IFRAME#`.

   {{% alert title="Note" color="info"%}}`#IFRAME#` is a "token"; it is replaced by Cuebot
   with the current frame number before each frame is sent to RQD for processing.{{% /alert %}}

1. Set Frame Spec to `1-3`.

1. Click **Submit**:

   ![A screenshot of CueSubmit with correct values](/docs/images/windows/verify_submit.png)

1. Switch back to CueGUI and verify that the job completes successfully:

   ![A screenshot of CueGUI with completed job](/docs/images/windows/verify_job_complete.png)

This verifies that your end-to-end installation is working.
