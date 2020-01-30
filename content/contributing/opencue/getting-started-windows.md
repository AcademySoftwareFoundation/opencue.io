---
title: "Setting up a development environment on Windows"
linkTitle: "Setting up a development environment on Windows"
date: 2020-01-29
weight: 2
description: >
  A guide to setting up an end-to-end development environment on Windows.
---

This is a guide to setting up a development environment on Windows that will allow 
you to run the entire OpenCue system from end-to-end (Cuebot, Cuesubmit, CueGUI, RQD)
and make changes to any part of it.

## Prerequisites

First, clone the [OpenCue git repository](https://github.com/AcademySoftwareFoundation/OpenCue)
to your machine. You will then need to download & install three core dependencies:

- [Postgres](https://www.postgresql.org/download/windows/)
- [Python 3.x](https://www.python.org/downloads/) 
- [Java SE JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html)

It is also useful to have IDEs installed. JetBrains has free versions of both:

- [PyCharm](https://www.jetbrains.com/pycharm/)
- [IntelliJ IDEA](https://www.jetbrains.com/idea/)

## Database setup

After installing Postgres you will need to create a database and user for OpenCue
(specifically CueBot) to use.

To do this you can either use the pgAdmin GUI (included with Postgres on Windows),
or the commandline Postgres client.

### Using the commandline

Download the `schema-*.sql` and `demo-*.sql` files from the [the releases page](https://github.com/AcademySoftwareFoundation/OpenCue/releases).

Open Powershell, then run `psql`:

```powershell
# Change the following path depending on what version of Postgres you have:
$psql = 'C:\Program Files\PostgreSQL\12\bin\psql.exe'
& $psql -U postgres
```

You will need to enter the password you set during Postgres installation.
Next, enter the following `psql` commands to set up the user and database:

```psql
create user opencue with password 'INSERT PASSWORD HERE';
create database opencue;
\connect opencue
alter default privileges in schema public grant all privileges on tables to opencue;
\include schema-*.sql # actual filename will change depending on version
set search_path = public;
\include demo_data-*.sql # actual filename will change depending on version
\quit
```

### Using the pgAdmin GUI

1. **Start pgAdmin**: Open pgAdmin from the Start menu. This will add an icon to the system tray. 
   Right-click the pgAdmin icon and select **New pgAdmin window…**, which will open 
   in your browser. Sign in with your Postgres admin user credentials that you selected during
   Postgres installation.
1. **Create User**: From the tree-view on the left, find **Login/Group Roles**. Right-click it and select
   **Create→Login/Group Role…**. Name the user `opencue` and choose a secure password, then hit **Save**.
1. **Create Database**: From the tree-view on the left, find **Databases**. Right-click it and
   select **Create→Database…**. Name the database `opencue`, then hit **Save**.
1. **Populate Database**: Next you will need to populate the database. Following the instructions on the
   [Setting up the Database](/docs/getting-started/setting-up-the-database/) 
   page to populate the database, you can:
   1. Download the latest `schema-*.sql` from [the releases page](https://github.com/AcademySoftwareFoundation/OpenCue/releases).
   1. In pgAdmin right-click the `opencue` database, and select **Query Tool…**.
   1. In the Query Editor click the **📂 Open File** icon and open the `.sql` file you downloaded.
   1. Click the **▶ Execute** icon to populate the database.
1. **Insert Demo Data**: You will also need the demo data to run the full environment locally.
   Download the latest `demo_data-*.sql` from the releases page and run it against the `opencue` database as in the previous step.
1. **Grant Permissions**: In pgAdmin, right click on the `opencue` database and select **Grant Wizard**.
   Use the select-all box to select all items, then select **Next**. Add the `opencue` user and select `ALL` privileges,
   then select **Next** again, and finally **Finish**.

## Configure Cuebot for local database access

Add the database and user credentials into `cuebot/src/main/resources/opencue.properties`, e.g.:

```
datasource.cue-data-source.driver-class-name=org.postgresql.Driver
datasource.cue-data-source.jdbc-url=jdbc:postgresql://localhost/opencue
datasource.cue-data-source.username=opencue
datasource.cue-data-source.password=xxxxxx
```

## Configure PyCue for local CueBot server

You will need to change the default servers for the `opencue` Python library, so that
it can find your local CueBot server. Open `pycue/opencue/default.yaml`, and edit
the end of the file to look like:

```yaml
cuebot.facility_default: local
cuebot.facility:
  local:
  - localhost:8443
```

## Generate gRPC .proto files

Generating the `.proto` gRPC protocol files for RQD and the PyCue library is currently a manual process.

First, open Powershell and install the required gRPC tools:

```powershell
pip install grpcio-tools
```

Next `cd` to the `proto` folder and run the following commands (from `proto/README.md`):

```powershell
python -m grpc_tools.protoc --proto_path=. --python_out=../rqd/rqd/compiled_proto --grpc_python_out=../rqd/rqd/compiled_proto (ls *.proto).Name
python -m grpc_tools.protoc --proto_path=. --python_out=../pycue/opencue/compiled_proto --grpc_python_out=../pycue/opencue/compiled_proto (ls *.proto).Name
```

The `.proto` files also need some post-processing to make them compatible with Python 3.
The easiest way to do this is to run `2to3`: 

```powershell
pip install 2to3
2to3 -wn (ls ../rqd/rqd/compiled_proto/*_pb2*)
2to3 -wn (ls ../pycue/opencue/compiled_proto/*_pb2*)
```

## Running CueBot

CueBot is the core component of OpenCue, written in Java.

To build and run it with IntelliJ IDEA:

1. Open IntelliJ IDEA and choose **Open**, select the `cuebot` folder in the git repository.
   The IDE will download and set up Gradle, if needed. This can take some time.
1. Browse to the `src/main/java/com.imageworks/spcue/CuebotApplication` file.
   Right-click the `main` method and choose **Run**. (This will alter the default Run 
   configuration so that you can use Shift+F10 to run it afterwards.)
1. Ensure that the output window doesn’t show any errors. If it does, double-check that you
   have set up the database correctly, including permissions, and have placed the connection
   settings into `main/resources/opencue.properties` (see above).

## Running CueSubmit

CueSubmit lets you submit jobs to OpenCue, it is written in Python.

To get setup and run it with PyCharm:

1. Open PyCharm and choose **Open**, select the `cuesubmit` folder in the git repository.
1. For the project interpreter, you can either set up a Venv (usually recommended if
   you are working on other Python projects), or leave it as the default Python interpreter.
1. PyCharm should prompt you to install ‘Package requirements’. If not, open the `setup.py`
   and the banner should appear. Select **Install Requirements** and wait for the packages
   to be installed. (PySide2 can take some time to install.)
1. You will need to add additional content roots to find the `opencue` and `outline` libraries.
   Under **File→Settings** find **Project: cuesubmit/Project Structure**; click the ➕ next
   to **Add Content Root** and add the `pycue` folder. Do the same with the `pyoutline` folder.
   Select **OK** to exit.
1. Right click on `cuesubmit/ui/__main__.py` and select **Run**.

## Running CueGUI

CueGUI lets you monitor the status of jobs and rendering hosts. It is written in Python.

To get setup and run it with PyCharm:

1. Open PyCharm and choose **Open**, select the `cuegui` folder in the git repository.
1. For the project interpreter, you can either set up a Venv (usually recommended if
   you are working on other Python projects), or leave it as the default Python interpreter.
1. PyCharm should prompt you to install ‘Package requirements’. If not, open the `setup.py`
   and the banner should appear. Select **Install Requirements** and wait for the packages
   to be installed. (PySide2 can take some time to install.)
1. You will need to add additional content roots to find the `opencue` library.
   Under **File→Settings** find **Project: cuegui/Project Structure**; click the ➕ next
   to **Add Content Root** and add the `pycue` folder.
   Select **OK** to exit.
1. Right click on `cuegui/__main__.py` and select **Run**.

## Running RQD

RQD is the OpenCue rendering host agent. It is written in Python.

To get set up and run it with PyCharm:

1. Open PyCharm and choose **Open**, select the `rqd` folder in the git repository.
1. For the project interpreter, you can either set up a Venv (usually recommended if
   you are working on other Python projects), or leave it as the default Python interpreter.
1. PyCharm should prompt you to install ‘Package requirements’. If not, open the `setup.py`
   and the banner should appear. Select **Install Requirements** and wait for the packages
   to be installed. 
1. Right click on `rqd/__main__.py` and select **Run**.

## Verify end-to-end

Once you are running CueBot, CueGUI, and RQD simultaneously, you should be able to see
the RQD host in CueGUI (in the **Monitor Hosts** section, check the **Auto-refresh** box):

![A screenshot of CueGUI showing host](/docs/images/windows/verify_host.png)

Next, you can check that you can run a job by running CueSubmit. Fill out Job, Shot,
and Layer Name as you like, and set the Command to `ping opencue.io`. Set Frame Spec to
`1`, then hit **Submit**:

![A screenshot of CueSubmit with correct values](/docs/images/windows/verify_submit.png)

Switch back to CueGUI and verify that the job completes successfully:

![A screenshot of CueGUI with completed job](/docs/images/windows/verify_job_complete.png)

This verifies that the end-to-end process is working.