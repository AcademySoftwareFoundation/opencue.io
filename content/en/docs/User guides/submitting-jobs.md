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

    A show is a group of related jobs for OpenCue to process. Jobs you submit
    to OpenCue exist within the context of a show.

1.  Enter the name for the **Shot** to send to OpenCue.

    A shot is a series of uninterupted frames you need to render. Choose a
    shot name that describes the shot that this job relates to, such as
    `ts_04`, short for 'Title sequence 4'.
    
    The following screenshot illustrates a completed job info form:
    
    ![CueSubmit job info form](/docs/images/cuesubmit_job_info.png)

1.  Enter a **Layer Name** to name the first layer in your job.

    {{% alert title="Note" color="info"%}}Layer names must contain more than
    3 characters and contain no spaces.{{% /alert %}}
    
    Choose a layer name that describes the task the layer is performing,
    such as 'rendering' or 'compositing'.

1.  In **Command to Run**, enter the shell command you want to run to render
    the layer.

    The command depends on the rendering software you're running. You can
    specify the frame number in the command to run at render time by
    specifying the `#IFRAME#` variable. For example, to render a range of
    frames using the 3D creation suite Blender, you can specify a command
    to run simiar to the following:
    
    ```bash
    /usr/local/blender/blender -b \
      -noaudio <path-blender-file>.blend \
      -o /renderoutput/ts_04.##### \
      -F JPEG \
      -f #IFRAME#
    ```
    
    In this example, based on the frame padding `#####`, OpenCue writes the
    output for frame 325 on disk, as file `ts_04.00325.jpg`.

1.  In **Frame Spec**, enter the range of frames you want to process.

    A frame spec consists of a start time, an optional end time, a step,
    and an interleave. To add multiple ranges together, separate them
    by commas. For detailed examples of the frame spec syntax, click **?**.

1.  Set **Job Type** to either **Shell** or the name of the software package
    you're using for this layer in the job.

1.  Select the required **Services** from the available list for your job.

    OpenCue matches jobs with machines, based on the selected service.
    
    The following screenshot illustrates a completed layer info form:

    ![CueSubmit layer info](/docs/images/cuesubmit_layer_info.png)

1.  Review the summary information in **Submission Details** to verify your
    settings, as illustrated by the following screenshot:
    
    ![CueSubmit submission details summary](/docs/images/cuesubmit_submission_details.png)

1.  Optionally, to add more layers to this job, click **+**.

1.  When you're ready to submit your job, click **Submit**.

## What's next?

-   [Troubleshooting rendering](/docs/other-guides/troubleshooting-rendering)
 
