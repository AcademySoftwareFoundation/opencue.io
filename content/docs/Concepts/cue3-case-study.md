---
title: "OpenCue and Cue3 case study"
linkTitle: "OpenCue and Cue3 case study"
weight: 3
date: 2019-10-02
description: >
  Running OpenCue and Cue3 infrastructure in production
---

This page provides a case study of how Sony Pictures Imageworks runs Cue3 on
production infrastructure. Cue3 is the original name for OpenCue prior to open
sourcing the project. This case study is aimed at system admins and other
professionals planning to install OpenCue. When planning a production
deployment of OpenCue, you can review this case study alongside the [OpenCue
getting started guide](/docs/getting-started/).

## Before you begin

Many of the OpenCue terms and concepts in this case study are explained in
more detail in the following introductory resources:

*   [OpenCue overview](/docs/concepts/opencue-overview/)
*   [Glossary](/docs/concepts/glossary/)

As you read through this case study, you might find it useful to refer to
these introductory resources.

## Cue3 components and specifications

The production deployment consists of the following components:

*   Several [CueBot](/docs/concepts/glossary/#cuebot) virtual machines (VMs)
    servers
*   A database server, known as CueDB, which stores data over a Network File
    System (NFS)
*   A render farm consisting of between 2,500 and 4,000 render nodes,
    including:
    *   Dedicated render nodes, which are equivalent to OpenCue render hosts
        running [RQD](/docs/concepts/glossary/#rqd)
    *   Artist workstations, also running RQD
*   A 10 Gb/s network

From their workstations, artists submit jobs to Cue3 through a cluster of
CueBot servers. The CueBot servers dispatch individual frames in a job to the
render farm. CueBot servers also store all persistent state and transactions
in the CueDB database server. Figure 1 illustrates how the various Cue3
infrastructure components interact:

![Cue3 infrastructure components](/docs/images/cue3_infrastructure_components.svg)

Figure 1. Cue3 infrastructure components

Each CueBot VM is provisioned as follows:

*   Managed via vSphere platform
*   Allocated 4-core CPUs (Intel Xeon L5640 running at 2.3 GHz)
*   Allocated 8 GB RAM

The CueDB server is provisioned as follows:

*   Runs on a bare metal server
*   Allocated 16-core CPUs (Intel Xeon E5-2670 running at 2.6 GHz)
*   Allocated 128 GB RAM

The back end storage is provisioned as follows:

*   Runs on a NetApp filer
*   Allocated the following types of storage:
    *   Primarily using Serial Attached SCSI (SAS) 10K drives
    *   Some SSD for caching
*   Connected to the database server over NFS

The current dataset occupies approximately 1.2 TB, including historical data.

## See also

To learn more about the production use of Cue3, see the [recording of the
OpenCue Birds of a Feather roadmap from SIGGRAPH
2019](/blog/2019/09/20/opencue-at-siggraph-recording/). In this recording,
Ben Dines from Sony Pictures Imageworks provides a summary of the development
and use of Cue3 on a number of films.

## What’s next?

*   To plan your production deployment of OpenCue, see the [OpenCue getting
    started guide](/docs/getting-started/).
*   To run OpenCue in a Docker sandbox environment on your workstation, see
    [quick starts](/docs/quick-starts/).
