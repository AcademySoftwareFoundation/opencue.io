---
title: "Submitting jobs"
linkTitle: "Submitting jobs"
date: 2019-03-15
weight: 1
description: >
  Submit rendering jobs to OpenCue from CueSubmit
---

This guide describes how to submit a job to OpenCue using the stand-alone
version of CueSubmit and configure relevant rendering settings. A job is a
collection of layers, which is sent as a script to the queue to be processed
on remote cores. Each job can contain one or more layers, which are sub-jobs
in an outline script job. Each layer contains a frame range and a command to
execute.

## Before you begin

Make sure your OpenCue admin has
[installed CueSubmit](/docs/getting-started/installing-cuesubmit/).

## Submitting a job

To submit a job to OpenCue:

1.  Start CueSubmit.

    {{% alert title="Note" color="info"%}}The instructions for running
    CueSubmit vary depending on the installation method. To learn more, see
    [Installing CueSubmit](/docs/getting-started/installing-cuesubmit)
    or contact your OpenCue admin.{{% /alert %}}

1.  Enter a **Job Name**.

    The job name is an arbitrary value that you choose when creating the
    job.
    
    {{% alert title="Note" color="info"%}}You can follow the naming convention
    for your rendering facility, as long as the job name is unique, contains
    more than 3 characters, and contains no spaces.{{% /alert %}}

1.  Select a **Show**.

    A show is a group of related jobs to be processsed. Jobs you submit to
    OpenCue exist within a show.

1.  Enter a **Shot**, which is a series of uninterupted frames you need to
    render.

1.  Enter a **Layer Name** to name the first layer in your job.

    {{% alert title="Note" color="info"%}}Layer names must contain more than
    3 characters and contain no spaces.{{% /alert %}}

1.  In **Command to Run**, enter the shell command you want to run to render
    the layer.

    The command depends on the rendering software you're running.

1.  In **Frame Spec**, enter the range of frames you want to process.

    A frame spec consists of a start time, an optional end time, a step,
    and an interleave. To add multiple ranges together, separate them
    by commas. For detailed examples of the frame spec syntax, click **?**.

1.  Set **Job Type** to either **Shell** or the name of the software package
    you're using for this layer in the job.

1.  Select the required **Services** from the available list for your job.

1.  Review the summary information in **Submission Details** to verify your
    settings.

1.  Optionally, to add more layers to this job, click **+**.

1.  When you're ready to submit your job, click **Submit**.

## What's next?

-   [Troubleshooting rendering](/docs/other-guides/troubleshooting-rendering)
 